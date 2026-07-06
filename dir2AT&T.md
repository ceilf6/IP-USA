# AT&T VPS 直连 SOCKS5 从零配置

这份文档适用于现在的情况：本地网络已经可以直接连到 VPS，不再需要先经过机场前置节点。你现在只需要 VPS IP 和 root 密码，就可以先 SSH 登录 VPS，再在 VPS 上安装一个 SOCKS5 服务，最后让 Clash Verge 或 Shadowrocket 直接连这个 SOCKS5。

下面假设 VPS IP 是：

```text
108.242.235.178
```

不要把 root 密码填进 Clash / Shadowrocket。root 密码只用于 SSH 登录 VPS；SOCKS5 会单独生成一个密码。

## 1. 本地先确认能直连 SSH

在 Mac 终端执行：

```bash
VPS_IP="108.242.235.178"
nc -vz -G 5 "${VPS_IP}" 22
```

看到类似下面的结果，说明当前网络可以直接连到 VPS 的 SSH 端口：

```text
Connection to 108.242.235.178 port 22 [tcp/ssh] succeeded!
```

如果这里失败，先不要继续安装 SOCKS5。需要检查当前网络、VPS 是否开机、服务商防火墙是否放行了 `22/tcp`。

## 2. 用 root 密码登录 VPS

继续在 Mac 终端执行：

```bash
ssh root@108.242.235.178
```

第一次登录时，如果提示是否信任指纹，输入：

```text
yes
```

然后输入你的 root 密码。密码输入时终端不会显示，这是正常的。

如果提示 `Permission denied`，说明 root 密码不对，或者服务商禁用了 root 密码登录，需要去 VPS 面板检查登录方式。

## 3. 在 VPS 上安装 SOCKS5

登录到 VPS 后，把下面整段命令复制到 VPS 终端执行。

默认配置：

- SOCKS5 用户名：`att`
- SOCKS5 端口：`33123`
- SOCKS5 密码：自动随机生成

```bash
set -e

GOST_VERSION="3.2.6"
PROXY_USER="att"
PROXY_PORT="33123"

apt update
apt install -y ca-certificates curl openssl tar ufw

PROXY_PASS="$(openssl rand -hex 16)"

ARCH="$(uname -m)"
case "${ARCH}" in
  x86_64)
    GOST_ARCH="amd64"
    ;;
  aarch64|arm64)
    GOST_ARCH="arm64"
    ;;
  *)
    echo "不支持的 CPU 架构：${ARCH}"
    exit 1
    ;;
esac

cd /tmp
curl -fL -o gost.tar.gz "https://github.com/go-gost/gost/releases/download/v${GOST_VERSION}/gost_${GOST_VERSION}_linux_${GOST_ARCH}.tar.gz"
tar -xzf gost.tar.gz
install -m 755 gost /usr/local/bin/gost

mkdir -p /etc/gost
cat > /etc/gost/config.yaml <<EOF
services:
- name: socks5
  addr: ":${PROXY_PORT}"
  handler:
    type: socks5
    auth:
      username: "${PROXY_USER}"
      password: "${PROXY_PASS}"
  listener:
    type: tcp
EOF

cat > /etc/systemd/system/gost.service <<EOF
[Unit]
Description=GOST SOCKS5 Proxy
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStart=/usr/local/bin/gost -C /etc/gost/config.yaml
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable --now gost

ufw allow 22/tcp
ufw allow "${PROXY_PORT}/tcp"
ufw --force enable

echo
echo "SOCKS5 信息如下，请保存："
echo "Host: 108.242.235.178"
echo "Port: ${PROXY_PORT}"
echo "Username: ${PROXY_USER}"
echo "Password: ${PROXY_PASS}"
echo

systemctl status gost --no-pager
```

注意：如果复制后终端里变成了 `"<https://github.com/...>"`，要删掉尖括号 `< >`。正确格式是 `"https://github.com/..."`。

如果 VPS 服务商面板里还有单独的防火墙 / Security Group，也要在那里放行：

```text
33123/tcp
```

## 4. 在 VPS 上自测 SOCKS5 是否工作

还是在 VPS 终端里执行：

```bash
curl -sS --connect-timeout 5 --max-time 20 \
  -x "socks5h://127.0.0.1:33123" \
  --proxy-user "att:你的SOCKS5密码" \
  https://api.ipify.org
echo
```

把 `你的SOCKS5密码` 换成上一步输出的 `Password`。

如果能输出一个 IP，说明 VPS 本机上的 SOCKS5 服务已经正常。

也可以检查服务和监听端口：

```bash
systemctl status gost --no-pager
ss -lntp | grep 33123
ufw status
```

## 5. 回到 Mac 测试远程 SOCKS5 端口

退出 VPS：

```bash
exit
```

在 Mac 终端执行：

```bash
nc -vz -G 5 108.242.235.178 33123
```

成功时会看到：

```text
Connection to 108.242.235.178 port 33123 [tcp/*] succeeded!
```

再用 SOCKS5 真实请求一次：

```bash
curl -sS --connect-timeout 5 --max-time 20 \
  -x "socks5h://108.242.235.178:33123" \
  --proxy-user "att:你的SOCKS5密码" \
  https://api.ipify.org
echo
```

如果这里能输出 VPS 的出口 IP，说明本地已经可以直接通过 VPS SOCKS5 出网。

## 6. Clash Verge 直连配置

如果你当前没有任何机场订阅 / 主配置，优先用本地配置文件，不要用全局扩展脚本。

原因是 Clash Verge Rev 里 `Remote` / `Local` 才是主配置，`Script` / `Merge` 只是增强配置。全局脚本不能单独作为一份主配置运行；如果 `订阅` 页面没有启用任何主配置，代理页可能只会显示 `DIRECT` / `REJECT`。

### 方式 A：没有订阅时，用本地配置文件

复制仓库里的 `att-residential.clash.yaml`，把这一行改成你的 SOCKS5 密码：

```yaml
password: "替换成你的SOCKS5密码"
```

然后在 Clash Verge：

```text
订阅 -> 新建 / 导入 -> Local / 本地文件 -> 选择 att-residential.clash.yaml
启用这份配置
代理 -> 顶部选择“规则”
Claude-ATT -> 选择 ATT-Residential
```

启用后，代理页应该能看到：

```text
ATT-Residential
Claude-ATT
DIRECT
REJECT
```

### 方式 B：已经有主订阅时，用全局扩展脚本

打开 Clash Verge 的 `全局扩展脚本 Script`，粘贴下面脚本。

只需要改一个地方：

```js
const VPS_PASS = "替换成你的SOCKS5密码";
```

完整脚本：

```js
function main(config) {
  const VPS_NAME = "ATT-Residential";
  const CLAUDE_GROUP = "Claude-ATT";

  const VPS_HOST = "108.242.235.178";
  const VPS_PORT = 33123;
  const VPS_USER = "att";
  const VPS_PASS = "替换成你的SOCKS5密码";

  config.proxies = config.proxies || [];
  config["proxy-groups"] = config["proxy-groups"] || [];
  config.rules = config.rules || [];

  config.proxies = config.proxies.filter((p) => p.name !== VPS_NAME);
  config["proxy-groups"] = config["proxy-groups"].filter(
    (g) => g.name !== CLAUDE_GROUP,
  );
  config.rules = config.rules.filter((rule) => !rule.includes(CLAUDE_GROUP));

  config.proxies.push({
    name: VPS_NAME,
    type: "socks5",
    server: VPS_HOST,
    port: VPS_PORT,
    username: VPS_USER,
    password: VPS_PASS,
    udp: false,
  });

  config["proxy-groups"].push({
    name: CLAUDE_GROUP,
    type: "select",
    proxies: [VPS_NAME, "DIRECT"],
  });

  config.rules = [
    `DOMAIN-SUFFIX,anthropic.com,${CLAUDE_GROUP}`,
    `DOMAIN-SUFFIX,claude.ai,${CLAUDE_GROUP}`,
    ...config.rules,
  ];

  return config;
}
```

推荐 Clash Verge 设置：

```text
代理模式：规则
Claude-ATT：选择 ATT-Residential
虚拟网卡模式 / TUN：开启
IPv6：关闭
```

如果你想让所有流量都走这个 VPS，可以临时切到 `全局` 模式，并选择 `ATT-Residential`。只访问 Claude 时，优先用 `规则` 模式。

如果保存脚本后没有看到 `ATT-Residential` 或 `Claude-ATT`：

1. 确认脚本最后有 `return config;` 和结尾的 `}`。
2. 在脚本窗口点击 `保存`。如果保存按钮是灰色，先随便加一个空格再删掉，让 Clash Verge 识别到变更。
3. 回到 `订阅` 页面，刷新当前订阅 / 配置，并确认它是当前启用的配置。
4. 回到 `代理` 页面，把顶部模式切到 `规则`。
5. 如果还是只有 `DIRECT` / `REJECT`，去 `日志` 页面搜索 `script`、`error`、`failed`，通常是脚本没有执行或执行时报错。

## 7. iPhone / Shadowrocket 直连配置

添加一个 SOCKS5 节点：

```text
Type / 类型：Socks5 或 Socks
Address / 地址：108.242.235.178
Port / 端口：33123
User / 用户名：att
Password / 密码：填 VPS 上输出的 SOCKS5 密码
Remark / 备注：ATT-Residential
```

这里和旧流程不同：不需要选择“代理通过”前置节点。如果 Shadowrocket 有 `Proxy Through / 代理通过`，保持不选或直连。

## 8. 最后验证

打开下面的网站检查出口 IP 和 Claude 可用性：

```text
https://ip.net.coffee/claude/
```

如果页面提示 DNS 泄漏，确认本地 Clash 配置里不要使用中国 DNS。`att-residential.clash.yaml` 已经内置了下面这些关键项：

```yaml
ipv6: false
tun:
  enable: true
  strict-route: true
  route-exclude-address:
    - 108.242.235.178/32
  dns-hijack:
    - any:53
    - tcp://any:53
dns:
  enable: true
  ipv6: false
  enhanced-mode: fake-ip
  respect-rules: true
  nameserver:
    - https://1.1.1.1/dns-query
    - https://1.0.0.1/dns-query
```

修改后在 Clash Verge 里执行：

```text
订阅 -> 选中 Att 本地配置 -> 刷新 / 更新
设置 -> IPv6：关闭
设置 -> DNS 设置：不要使用 system、114.114.114.114、223.5.5.5、223.6.6.6、doh.pub、dns.alidns.com
代理 -> 顶部选择“全局”或“规则”
```

如果只是访问 Claude，推荐 `规则` 模式并让 `Claude-ATT` 选择 `ATT-Residential`。如果要做全局出口一致性测试，可以临时切到 `全局` 并选择 `ATT-Residential`。

如果重新导入配置后节点显示 `Timeout`，先在 Mac 上分开测：

```bash
nc -vz -G 5 108.242.235.178 33123
curl -sS --connect-timeout 5 --max-time 20 -x http://127.0.0.1:7897 https://api.ipify.org
echo
```

如果两条都成功，说明节点实际可用，Clash Verge 的测速状态可能是旧状态，或者 TUN 刚启动时短暂自绕。确认配置里有：

```yaml
tun:
  route-exclude-address:
    - 108.242.235.178/32
```

然后重载 Clash 内核，再点一次节点测速。

时区和语言不一致不是 Clash/TUN 能修的，它们来自浏览器和系统：

```text
时区：macOS 系统设置 -> 通用 -> 日期与时间 -> 时区 -> America/Los_Angeles
语言：Chrome -> Settings -> Languages -> English (United States) 放到首位
```

改完后重启 Chrome，再重新打开检测页面。

也可以在 Mac 上用命令验证：

```bash
curl -sS --connect-timeout 5 --max-time 20 \
  -x "socks5h://108.242.235.178:33123" \
  --proxy-user "att:你的SOCKS5密码" \
  https://api.ipify.org
echo
```

## 9. 常见问题

### `ssh root@108.242.235.178` 连不上

先测：

```bash
nc -vz -G 5 108.242.235.178 22
```

如果 `22/tcp` 不通，问题还在 SSH 直连层面，先检查 VPS 是否开机、服务商防火墙是否放行 `22/tcp`。

### `33123` 端口连不上

在 VPS 上检查：

```bash
systemctl status gost --no-pager
ss -lntp | grep 33123
ufw status
```

如果 VPS 本机正常，但 Mac 连不上，通常是服务商面板防火墙没有放行 `33123/tcp`。

如果 Mac 上表现为：

```text
22/tcp succeeded
33123/tcp Operation timed out
```

说明 SSH 入口是通的，但 SOCKS5 端口被防火墙静默丢包。回 VPS 执行：

```bash
ufw allow 33123/tcp
ufw reload
systemctl restart gost
ss -lntp | grep 33123
ufw status verbose
```

然后回 Mac 重新测：

```bash
nc -vz -G 5 108.242.235.178 33123
```

如果还是超时，去 VPS 服务商控制台 / Security Group / 防火墙规则里放行：

```text
33123/tcp
source: 0.0.0.0/0
```

如果服务商控制台不能放行高位端口，可以把 SOCKS5 改到 `443/tcp`。先确认 VPS 没有占用 443：

```bash
ss -lntp | grep ':443 ' || echo '443 is free'
```

然后改 GOST 配置里的端口并重启：

```bash
sed -i 's/addr: ":33123"/addr: ":443"/' /etc/gost/config.yaml
ufw allow 443/tcp
systemctl restart gost
ss -lntp | grep ':443 '
```

Clash Verge 里也要把端口同步改成：

```yaml
port: 443
```

### `systemd` 显示 Started，但 `curl -x socks5h://127.0.0.1:33123` 没输出

`Started` 只说明 GOST 进程启动了，不代表 SOCKS5 认证、DNS 解析和 VPS 出站访问都成功。先用配置文件里的密码，避免手输错：

```bash
PROXY_PASS="$(awk -F'"' '/password:/{print $2}' /etc/gost/config.yaml)"

curl -v --connect-timeout 5 --max-time 20 \
  -x "socks5h://127.0.0.1:33123" \
  --proxy-user "att:${PROXY_PASS}" \
  https://api.ipify.org
echo
```

如果还是没输出，再看完整日志：

```bash
systemctl status gost -l --no-pager
journalctl -u gost -n 100 -l --no-pager
```

同时确认 VPS 自己能直连外网：

```bash
curl -v --connect-timeout 5 --max-time 20 https://api.ipify.org
echo
```

### `curl: (3) URL using bad/illegal format`

检查你的 `curl` 命令里是不是带了尖括号：

```bash
curl -fL -o gost.tar.gz "<https://github.com/...>"
```

这是错误写法。改成：

```bash
curl -fL -o gost.tar.gz "https://github.com/..."
```

然后重新执行第 3 节的安装命令。

### SOCKS5 密码忘了

在 VPS 上查看：

```bash
cat /etc/gost/config.yaml
```

也可以重新生成密码后重启服务：

```bash
PROXY_PASS="$(openssl rand -hex 16)"
sed -i "s/password: .*/password: \"${PROXY_PASS}\"/" /etc/gost/config.yaml
systemctl restart gost
echo "${PROXY_PASS}"
```

然后把 Clash Verge / Shadowrocket 里的密码同步改掉。
