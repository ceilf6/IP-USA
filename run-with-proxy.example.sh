# Bash / Zsh 示例：出口 IP 校验通过后才启动命令。
# 依赖：curl、python3，以及已运行的本地 HTTP 代理。
# 填写占位配置后，可加入 ~/.zshrc 或 ~/.bash_profile。
# 加载配置只定义函数和别名；调用 claude 时才请求 ipinfo.io 并尝试启动。
# 校验仅覆盖检测时刻，不保证所有后续请求使用相同出口。

# >>> RUN WITH PROXY >>>
run_with_proxy() {
    (
        if (( $# == 0 )); then
            printf '用法：run_with_proxy <命令> [参数...]\n' >&2
            exit 2
        fi

        local cmd="$1"
        shift
        local expected_ip="YOUR_EXPECTED_EXIT_IP"
        local proxy="http://127.0.0.1:YOUR_HTTP_PROXY_PORT"

        # 必须填写实际出口 IP 和支持 HTTP 代理的本地端口。
        if [[ "$expected_ip" == "YOUR_EXPECTED_EXIT_IP" || "$proxy" == *YOUR_HTTP_PROXY_PORT* ]]; then
            printf '请先填写 expected_ip 和 proxy，再运行命令。\n' >&2
            exit 2
        fi

        export TZ="America/Los_Angeles"
        export CLAUDE_CODE_THRIFTY_SONIC=0
        export http_proxy="$proxy" https_proxy="$proxy" all_proxy="$proxy"
        export HTTP_PROXY="$proxy" HTTPS_PROXY="$proxy" ALL_PROXY="$proxy"

        # 绕过 HTTP 代理后，流量仍由系统路由、TUN 和VPN处理。
        local bypass="localhost,127.0.0.1,::1"
        # 按需添加内部域名，例如 corp.example,.corp.example。
        # bypass+=",corp.example,.corp.example"
        export no_proxy="$bypass" NO_PROXY="$bypass"

        local info parsed ip city region country org
        printf '\033[2m◌ 正在通过 ipinfo.io 检查代理出口…\033[0m\r'

        # 显式指定入口，确保检测请求使用代理。
        if ! info=$(curl -q -fsS \
            --proxy "$proxy" \
            --noproxy "" \
            --connect-timeout 5 \
            --max-time 10 \
            https://ipinfo.io/json 2>/dev/null); then
            printf '\033[K代理检测失败：无法通过 %s 访问 ipinfo.io。\n' \
                "$proxy" >&2
            exit 1
        fi

        if ! parsed=$(printf '%s' "$info" | python3 -c '
import json, sys
data = json.load(sys.stdin)
keys = ("ip", "city", "region", "country", "org")
values = [
    " ".join(str(data.get(key) or "-").split())
    for key in keys
]
print("\t".join(values))
' 2>/dev/null); then
            printf '\033[K代理检测失败：无法解析 ipinfo.io 响应。\n' >&2
            exit 1
        fi

        IFS=$'\t' read -r ip city region country org <<< "$parsed"
        if [[ "$ip" != "$expected_ip" ]]; then
            printf '\033[K\033[1;31m✗ 出口不符，已阻止启动\033[0m\n' >&2
            printf '  当前：%s\n  预期：%s\n  代理：%s\n' \
                "$ip" "$expected_ip" "$proxy" >&2
            exit 1
        fi

        printf '\033[K\033[1;32m✓ 代理出口校验通过\033[0m\n'
        printf '  IP：%s\n  位置：%s, %s, %s\n  运营商：%s\n' \
            "$ip" "$city" "$region" "$country" "$org"
        printf '  时区：%s\n  启动：%s\n\n' "$TZ" "$cmd"
        exec "$cmd" "$@"
    )
}

alias claude='run_with_proxy claude'
# <<< RUN WITH PROXY <<<
