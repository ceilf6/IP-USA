我的吸毒之路： 如何体验 Claude Code？
偶然的契机，让我体验到了 TRAE 内场版的 模
openrouter-1o
型，然后...我就...再也...回不去了...
但... 限额使⽤？ 那我的毕设怎么办！！

⾁⾝在中国，只通过⽀付宝⽀付，
如何购买获得 Claude Max 服务并减少被封号的概率？
我将分享我的⽅案。(Work in progress...)
References
• Claude 订阅与使⽤避坑指南
• ChatGPT订阅报销全流程实践
• GPT/CLAUDE 苹果报销流程
• 如何让你的Claude活得更久—⽹络篇
• ⻛险隔离、iOS / Android 通⽤的 Claude 订阅及防⻛控实践
• 5分钟，搞定 Claude Code 订阅代理问题
• Claude Code 封号机制深度探查报告
• 如何在公司愉快的使⽤ Claude Code (合规不封号)
• 字节跳动 AI 产品体验费⽤报销制度
• AI产品体验费⽤报销指引 | AI Product Expense Reimbursement Guidance
道路千万条，合规第⼀条。
禁⽌使⽤ Claude Code 打开公司仓库，不要在公司电脑上配置 Clash 等三⽅ VPN 软件哦。
• 公司内使⽤Claude Code和Codex的合规说明
• AI产品安全合规使⽤FAQ
• DataSecurity-303-字节跳动数据分类分级安全保护措施基线要求
• 字节跳动信息安全管理框架制度
0x00 效果总览
0x0000 什么情况下会被封号？

送钱给 Anthropic 不是难事，难的是如何让 Anthropic 不要把钱退给你。
可能原因 解决⽅案
⽹络 IP 相关⻛险 选择静态美国住宅 IP ，通过 Scamalytics（Fraud
Score < 10）、ipinfo.io、ping0.cc（⻛控值标签
使⽤数据中⼼ IP、IP 纯净度低（Fraud Score 过⾼、
为"纯净"）、IPQualityScore（⽆ VPN/Proxy 标记）
存在 VPN/Proxy 标记等）、IP 频繁轮换、IP 与 DNS
等平台交叉验证 IP 纯净度。
解析地址不⼀致等，会被 Anthropic ⻛控系统识别为
异常⽤⼾。
账号注册与⽀付⻛险 选择 App Store/Google Play 中转付款，隐藏国内卡
信息，降低因⽀付渠道导致的封号⻛险。
使⽤来源不明的礼品卡（如⿊卡）订阅、注册信息不
规范（如临时接码平台号码存在⻛险）、新注册账号 注册时选择正规接码平台获取临时号码，注册后可设
⽴即⾼强度使⽤等，可能触发平台⻛控。 置个⼈信息，模拟真实⽤⼾⾏为，避免新账号⽴即⾼
强度使⽤。
使⽤⾏为⻛险 遵守平台服务条款，使⽤官⽅认可的⽅式访问
Claude，避免使⽤违规中转⼯具。
违反 Anthropic 服务条款（如使⽤ Sub2API 等协议转
译⼯具）、账号多设备登录或共享使⽤、触发⾝份验 避免账号共享，保持设备与⽹络环境的⼀致性，若触
证机制未通过等，可能导致账号封禁。 发⾝份验证，按要求提供有效证件完成验证。
模拟真实⽤⼾路径，不要⼀上来就开通 Max 20x 然后
猛蹬。我的操作是先聊天聊到上限，然后开通 Pro 版
本尝试⽤⼀下 Claude Code，再 Upgrade
Subscription 到 Max 20x，⽤ Pro 的退款再拿来开通
GPT Plus。
不要通过⾃动化滥⽤，不要使⽤⾮官⽅客⼾端。
可能原因还有很多，你要做的就是⸺“把⾃⼰像⽔⼀样融⼊⼤海”。
• 所有⻛控策略都是⿊盒。 除了 Anthropic 内部的⻛控团队，没有⼈知道确切的规则和权重。我们能做的，
只是根据现象反推逻辑，结合经验做出判断。⽬前没有内部信息。
• ⻛控是概率题，不是是⾮题。 ⻛控系统做的事情，是给每个⽤⼾打⼀个"⻛险分"，综合多个信号交叉判
断。这就导致了⼀个现象：同样的操作，A 做了没事，B 做了被封。不是因为规则不⼀致，⽽是两个⼈的其
他信号组合不同，最终得分不同。
基于以上“可能原因”，搭建⼀条独享的、可由美国住宅出⼝的⽹络通道显得尤其重要。但直连美国
住宅 VPS 往往会因跨洋线路差遇到⽹络问题，所以我们还需要⼀条可靠的跨洋传输线路。因此，“搬
⽡⼯ VPS”及其 CN2 GIA 跨洋线路和“美国住宅 VPS”是我解决⽹络 IP 相关⻛险的核⼼⽅案。前者不
仅可以⽤来中转我们和美国住宅 VPS 的连接，还可以⽤于平时的跨洋冲浪，后者则是我们访问
Anthropic 服务的核⼼出⼝。
此外，为规避可能的⽀付⻛险，我还会分享⼀下如何注册美区 Apple ID 并通过美区 App Store 完成订
阅。

最后，为了实现⾃动的⽹络分流，我还会分享⼀下 Clash 分流规则和家庭⽹络中枢的配置⽅案。
先让我们来看看最终效果吧。
0x0001 ⽹路拓扑
家庭⽹络拓扑。在公司或其他设备的话还是要安装⼀下 Clash Verge 通过软件进⾏分流。
| 出⼝ | ping0.c | ipinfo.i | ⽤途 | 优势 | 劣势 | 价格 | ⽤途 |
| ------ | ------- | -------- | ----- | ------- | ----- | ----- | ----- |
| | c | o | | | | | |
| 上海家宽 | | | 国内直连 | • 国内服务速 | • 国际服 | 500Mb | 访问国内⽹ |
| IP 出⼝ | | | | 度快 | 务受阻 | ps | 站， |
Steam、爱
960 元/
奇艺等⾼速
年
下载
| 美国机房 | | | 国际，稳定型 | • 国际服务畅 | • 延迟略 | 50$/季 | 访问⼀些略 |
| ------ | --- | --- | ------ | ------- | ----- | ----- | ----- |
| | | | | 通 | ⾼（〜 | | |
| IP 出⼝ | | | 场景 | | | 度 | 敏⽹站 |
150ms
• Apple ⽀付
）
• YouTube
视频
| 美国家宽 | | | 国际，⾼纯净 | • 美国服务绝 | • 速率较 | 149 元/ | 访问⾼敏⽹ |
| ------ | --- | --- | --------- | ------- | ----- | ------ | ----- |
| IP 出⼝ | | | 型场景 | 对畅通 | 低 | ⽉ | 站 |
| | | | • Claude | | • 延迟略 | | |
⾼（〜
Netflix
•
150ms
）
| 多地机场 | | | 国际，效率型 | 国际服务速 | | 108 元/ | 访问 |
| ----- | --- | --- | ------ | ----- | --- | ------ | --- |
•
| IP 出⼝ | | | 场景 | 度快 | | 年 | Github 等低 |
| ------ | --- | --- | --- | --- | --- | --- | --------- |

• Google • 部分⽹ 敏⽹站
站被封
• ⼩⽹站
锁
0x0002 Claude Code
吸上毒了！
0x0003 流媒体
由于搭建了美国家宽出⼝，常⻅的流媒体经过分流也可以正常访问了
iPhone 连上家庭 Wi-Fi PlayStation 5 主机⾃带的 Netflix 应⽤，正常打开
后⽆需安装任何代理软件

即可访问 Netflix 操作登
录
0x0004 任务列表
注册美区 Apple ID ⸺ ⽤于后续 App Store 内购⽀付
购买搬⽡⼯ VPS ⸺ 享受 CN2 GIA ⾼贵的跨洋传输线路
购买美国住宅宽带 VPS ⸺ 像美国本地⼈⼀样上⽹
购买 GL-MT6000 ⸺ 家庭⽹络中枢，安装 OpenClash 实现路由分流
配置搬⽡⼯ VPS、美国家宽 VPS、GL-MT6000 及 OpenClash
安装 Claude、Claude Code，并购买
0x01 美区 Apple ID
因为我没有国外银⾏卡，在国内也没有信⽤卡，只有银联储蓄卡，所以购买国际服务只能⾛ App
Store 这条路。因此，我需要先注册⼀个美区 Apple ID，然后通过礼品卡的⽅式向内充值，再通过内购
获得国际服务。
0x0101 注册美区 Apple ID
我的⼿机系统是 iOS26，经测试，⽹上的⼤部分注册教程都不适⽤。我来分享⼀下我的⽅案。
1. 准备⼀个新的邮箱，确保邮箱⽤⼾名包含⾃⼰的姓名拼⾳
◦ 这⾥要求有姓名拼⾳主要是为后续报销流程服务
◦ 我⽤的是⾃⼰的域名邮箱，⽐较⽅便
2. 挂上美国梯⼦，前往 https://appleid.apple.com/us/ 进⾏注册
◦ ( ) — Create Your Apple Account
☰
◦ First Name: 你的名字的拼⾳
◦ Last Name: 你的姓⽒的拼⾳
◦ Country/Region: United States
◦ Email: ⽆所谓，我的 cn 域名邮箱也可以
◦ Phone: ⽆所谓，+86 ⼿机号也可以
◦ 有时候会提⽰「Your account cannot be created at this time。」
▪ 打开⼿机上的「Apple ⽀持」/ 浏览器打开 「https://getsupport.apple.com/」
▪ 搜索主题「⽆法注册」
▪ 拉到下⽅，选择「获取更多协助」
▪ 「联系⽀持⼈员」—「实时聊天」

▪ 跟客服讲⼀下你⽆法注册，给⼀下注册邮箱，然后他会帮你调整权限
▪ 调整后就可以成功注册了
3. 注册完成后，添加账单地址
◦ https://account.apple.com/account/manage
◦ Payment & Shipping — Shipping Address
◦ 添加⼀个 Oregon 俄勒冈州（免税州）的美国地址
▪ https://www.shenfendaquan.com/ 可⽣成美国地址
▪ Street、City、State、Zip 按上述⽹站⽣成信息填写
▪ First/Last Name 还是填⾃⼰的姓名拼⾳
4. 打开⼿机 App Store，先切换⼀个⾮国区账号（我⽤的是港区）
◦ iOS 26.4 最新的 App Store，如果直接登录新账号，会复⽤「上⼀个登录账号」的商店地区版本
◦ 所以如果先前登录国区账号，然后直接登录我们的新美区账号的话，会直接被切回国区，⽽国
区是切不到其他区域的
5. 确定⾮国区商店登录成功后，再切换登录我们的新美国账号
◦ 登录后，地区会⾃动切换（像我就是⾃动切换回港区，但不要着急）
◦ 再前往 https://account.apple.com/account/manage
◦ Personal Information — Country / Region
◦ 切换回美国，会要求添加⽀付⽅式，选择⽆⽀付⽅式，再填⼀次之前添加过的账单地址
6. 再回到商店，随便下载⼀个国外应⽤（如 Gemeni）
◦ 这个时候 App Store 会提⽰你类似「当前在⾹港商店，⽆法下载，是否切回美国商店」之类的
提⽰
◦ 点击切换商店
◦ 这个时候就会打开美区的 App Store 商店了
7. ⾄此，美区账号注册成功
0x0102 为美区 Apple ID 充值
GPT/CLAUDE 苹果报销流程⽂档提到可以在美区官⽹⾃助购买礼品卡，后续如果被封号的话可以直
接退款到银⾏卡⾥。但我试了⼀下，美区官⽹不认我的国内银联储蓄卡，所以这⾥还是分享⽀付宝礼
品卡购卡⽅案。
1. 打开⽀付宝，左上⻆地区，切换到「旧⾦⼭」
2. 底部 Navigation Bar 切换到「优惠」
3. 在「⼤牌礼卡」中找到「精选⼤牌折..」

4. 在打开的「Pockyt Shop」中找到「App Store & Itunes USA」
5. 输⼊要充值的⾦额，「⽴即购买」
6. 付款成功后，⼀分钟内会给到 Gift Card Number
7. 打开 App Store，点右上⻆头像，选择「兑换代码」
8. 输⼊上⾯的 Gift Card Number，完成充值
最近发现招商银⾏的万事达储蓄卡还挺好申请的，搭配美区
PayPal 使⽤可以直接绑上美区 AppStore，后⾯会更新下教
程。
0x0103 通过美区 Apple ID 付款
1. 打开 App Store，找到要付款的 App（Claude）
2. 下载并登录后，直接购买，发起苹果内购，扣余额购买
3. 刚注册的账号⼤概率被⻛控（“⽆法完成你的购买”）
不打电话的⽅案（英语沟通） 中⽂沟通的⽅案（打电话）
• 访问 https://getsupport.apple.com/ 记得 • 拿起⼿机，拨打 400-666-8800
挂梯⼦，否则会接⼊中国区客服，就⼜要⾛
如果舍不得话费的话，也可以不挂梯⼦⾛
右边的⽅案了。
左边的流程，中国区的在线客服会为你安
• 搜索主题「⽆法注册」 排电话呼⼊。

• 拉到下⽅，选择「获取更多协助」 • 根据提⽰⾳转接到账号问题-其他问题
• 「联系⽀持⼈员」—「实时聊天」 • 选择流⾏⾳乐，然后跟接⼊的客服说你想要
转接到国际同事，你有美国区 Apple 账号遇
• 告诉客服你遇到了“⽆法完成购买”的问
到问题，具体是在 APP 操作订阅时“⽆法
题，并提供你的账号
完成购买”，并提供你的账号。
• 打开
• 继续⼀段流⾏⾳乐后，会有国际中⽂客服
https://account.apple.com/account/man
（我的是台湾⼩哥）介⼊，再次跟你确认情
age 并登录美区账号，然后⽣成⼀个「⽀持
况。
PIN」交给客服
• 你需要打开并登录美区账号（可以打电话前
• 他会告诉你已登记，48 ⼩时后再试
操作）
https://account.apple.com/account/man
age
• 找到左下⻆的「⽀持 PIN」并⽣成，告诉客
服，然后他就会告诉你已登记，48 ⼩时后
再试
48 ⼩时后你的账号不⼀定会恢复，如果没有恢复，请重试以上流程。可能被⻛控的原因包括：
1）新注册的账号；2）通过中国 IP 发起订阅操作付款；3）批量购买，即不断尝试购买。
0x02 搬⽡⼯ VPS
搬⽡⼯是成⽴于 2012 年的⼀家加拿⼤公司，⾪属于成⽴于 2004 年的 IT7，⾏业⽼炮做后盾，搬⽡⼯
VPS 早年以廉价稳定策略迅速打开国内市场并且普及，坐拥海量国内客⼾。
使⽤ Claude Code 需要国际联⽹，所以我们需要购买⼀台国外的服务器进⾏中转。搬⽡⼯以其独特的
CN2 GIA 路线深得⺠⼼。
CN2 GIA 是中国电信旗下的⾼端国际专线⽹络。
CN2 是中国电信的第⼆代⻣⼲⽹（ChinaNet Next Carrying Network），相⽐普通电信线路有更低
的延迟和更稳定的路由。
GIA（Global Internet Access）是 CN2 ⾥的顶级档位，全程⾛电信⾃⼰的专属线路，不和普通⽤⼾
共享带宽，进出中国⼤陆的路由都经过优化，⾼峰期也不会严重拥堵。
实际意义：搬⽡⼯的 CN2 GIA 线路回国延迟低、速度稳，这也是它⽐普通 VPS 贵的原因。⽤它承担
的是所有流量的第⼀跳，线路质量直接影响整体体验。
0x0201 购买搬⽡⼯ VPS
购买⼊⼝：https://bandwagonhost.com/aff.php?aff=81415 <-- ⽤ aff 好像有优惠，介意可以删除
选择 E-Commerce VPS — Los Angeles — USCA_9 区的机房机器，享受 CN2 GIA 线路。

购买后，主⻚右上⻆可进⼊「Client Area」，再进⼊「Services」—「My Services」。
在⾥⾯可以看到⾃⼰购买的 VPS 的 IP 地址，「Manage」—「Open KiwiVM」可以打开 VPS 管理⾯
板，重装系统。当然，你也可以直接查看⾃⼰的电⼦邮箱，如果你不需要重装系统的话。
0x0202 配置中转代理（直出）
安装 3x-ui ⾯板，⼀键配置 Xray。
https://github.com/MHSanaei/3x-ui
代码块
1 curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh |
bash

安装后，根据终端输出信息，找到 Web ⾯板登录⼊⼝、默认⽤⼾名和密码等信息，登录⾯板。
代码块
1 ...
2 ... # 前⾯省略⼀堆输出
3 ...
4 ═══════════════════════════════════════════
5 Panel Installation Complete!
6 ═══════════════════════════════════════════
7 Username: <random-username>
8 Password: <random-password>
9 Port: <random-panel-port>
10 WebBasePath: <random-base-path>
11 Access URL: https://<your-bandwagon-ip>:<random-panel-port>/<random-base-path>
12 ═══════════════════════════════════════════
13 ...
14 ... # 后⾯都没⽤，主要是上⾯这⾥，有默认登录⼊⼝、⽤⼾名密码等
15 ...
16 Setting up systemd unit...
17 Created symlink /etc/systemd/system/multi-user.target.wants/x-ui.service →
/etc/systemd/system/x-ui.service.
18 x-ui v2.8.11 installation finished, it is running now...
19
20 ┌───────────────────────────────────────────────────────┐
21 │ x-ui control menu usages (subcommands): │
22 │ ││
│
23 │ x-ui - Admin Management Script │
24 │ x-ui start - Start │
25 │ x-ui stop - Stop │
26 │ x-ui restart - Restart │
27 │ x-ui status - Current Status │
28 │ x-ui settings - Current Settings │
29 │ x-ui enable - Enable Autostart on OS Startup │
30 │ x-ui disable - Disable Autostart on OS Startup │
31 │ x-ui log - Check logs │
32 │ x-ui banlog - Check Fail2ban ban logs │
33 │ x-ui update - Update │
34 │ x-ui legacy - Legacy version │
35 │ x-ui install - Install │
36 │ x-ui uninstall - Uninstall │
37 └───────────────────────────────────────────────────────┘
38 ray@wagon:~$

在⼊站规则（InBound）中新增⼊站，选择 VLESS+Realtiy 协议，⽣成公私钥，保存，复制订阅链
接。
配置完 3x-ui ⾯板之后记得通过 ufw 关闭⾯板的公⽹访问，关闭后可以通过打 SSH 隧道的⽅式访问，
忽略证书错误即可。我上⾯的截图就是通过隧道访问的，⾯板暴露在公⽹可能存在被 GFW 扫到的⻛
险。
代码块
1 # === in bandwagon ===
2 sudo ufw allow 22
3 sudo ufw allow <vless-port>
4 sudo ufw deny <bandwagon-panel-port>
5 sudo ufw enable
6
7 # === in your computer ===
8 ssh -N -L <local-port>:localhost:<bandwagon-panel-port> <bandwagon-ip> &
9 open -a "Google Chrome" "https://localhost:<local-port>" # and ignore
certificate error
0x0203 配置中转代理（绕家宽）
代码块
1 # Install Gost
2 wget https://github.com/go-
gost/gost/releases/download/v3.2.6/gost_3.2.6_linux_amd64v3.tar.gz
3 tar -xzf gost_3.2.6_linux_amd64v3.tar.gz
4 sudo mv gost /usr/local/bin/
5 chmod +x /usr/local/bin/gost
6
7 # Configure Gost
8 sudo mkdir -p /etc/gost
9 sudo touch /etc/gost/config.yaml
10 cat <<'EOF' | sudo tee /etc/gost/config.yaml > /dev/null
11 chains:

12 - name: residential-chain-tcp
13 hops:
14 - name: hop1
15 nodes:
16 - name: residential
17 addr: "<your-residential-ip>:33123"
18 connector:
19 type: socks5
20 auth:
21 username: "<your-custom-username>"
22 password: "<your-custom-password>"
23 dialer:
24 type: tcp
25
26 - name: residential-chain-udp
27 hops:
28 - name: hop1
29 nodes:
30 - name: residential
31 addr: "<your-residential-ip>:33123"
32 connector:
33 type: socks5
34 auth:
35 username: "<your-custom-username>"
36 password: "<your-custom-password>"
37 dialer:
38 type: udp
39
40 services:
41 - name: forward-tcp
42 addr: "0.0.0.0:44123"
43 handler:
44 type: socks5
45 auth:
46 username: "<your-custom-username>"
47 password: "<your-custom-password>"
48 chain: residential-chain-tcp
49 listener:
50 type: tcp
51
52 - name: forward-udp
53 addr: "0.0.0.0:44123"
54 handler:
55 type: socks5
56 auth:
57 username: "<your-custom-username>"
58 password: "<your-custom-password>"

59 chain: residential-chain-udp
60 listener:
61 type: udp
62 EOF
63
64 # Configure Service
65 cat <<'EOF' | sudo tee /etc/systemd/system/gost.service > /dev/null
66 [Unit]
67 Description=GOST Proxy Service
68 After=network.target
69
70 [Service]
71 Type=simple
72 ExecStart=/usr/local/bin/gost -C /etc/gost/config.yaml
73 Restart=on-failure
74 RestartSec=5s
75
76 [Install]
77 WantedBy=multi-user.target
78 EOF
79 sudo systemctl daemon-reload
80 sudo systemctl enable gost
81 sudo systemctl start gost
82 sudo systemctl status gost
83
84 # Configure Firewall
85 sudo ufw allow in on lo to any port 44123
86 sudo ufw deny 44123
87 sudo ufw reload
88
89 # Test
90 curl --socks5 <your-custom-username>:<your-custom-password>@<your-bandwagon-
ip>:44123 https://ipinfo.io
0x03 美国家宽 VPS
0x0301 购买家宽 VPS
这⾥我买了两家同⼀个公司提供的美国家庭住宅宽带 VPS 服务（买 AaIT 的时候没货，转去买 AaITR，
结果也没货，在付完款等待 AaITR 补货时 AaIT ⼜上货了）（结果 AaITR 的 Frontier 补完货还没我的
份，⽬前还在等 AT&T 的补货）。
AaIT AaITR 其他
官⽹

https://www.aait.io/? https://www.aaitr.com/aff.ph 其他的我没试过，就不推荐
| | aff=EEYGYYWJ | p?aff=268 | 了。好像价格都⽐左边这两 |
| --- | ------------- | ---------- | ------------ |
家要低，最低的⼀个⽉甚⾄
| | ^ 同样，介意可删 aff 再访问 | ^ 同样，介意可删 aff 再访问 | |
| --- | ------------------ | ------------------ | --- |
只需要不到 4 美元。如有需
| 价格 | 299CNY/month+ | 149CNY/month+ | 要可以到⽂章最上⽅的 |
| --- | -------------- | -------------- | ----------- |
References ⽂章⾥去找
| 配置 | CPU：1vCPU（可选配） | CPU：2vCPU （可选配） | |
| --- | --------------- | ---------------- | --- |
找。
| | 内存：1GB（可选配） | 内存：2GB （可选配） | |
| --- | ----------------- | ------------------ | --- |
| | 硬盘：20GB SSD（可选配） | 硬盘：25GB SSD （可选配） | |
| | IP： 1 个独享静态住宅 IP | 带宽：100Mbps （峰值可选 | |
| | 带宽：30Mbps（可选配） | 配） | |
| | 流量：⽆限制 | 流量：2000GB （双向可选配） | |
位置：美国 加州 多城多段随机
| 备注 | 经常显⽰售罄，但多刷刷有⼏率 | 性价⽐⾼，但买不到也没招；静 | |
| --- | --------------- | -------------- | --- |
| | 捡漏；需要实名认证（1 元） | 态家宽不需要实名认证 | |
0x0302 配置中转代理
代码块
1 # Install Gost
2 wget https://github.com/go-
gost/gost/releases/download/v3.2.6/gost_3.2.6_linux_amd64v3.tar.gz
3 tar -xzf gost_3.2.6_linux_amd64v3.tar.gz
4 sudo mv gost /usr/local/bin/
5 chmod +x /usr/local/bin/gost
6
7 # Configure Gost
8 sudo mkdir -p /etc/gost
9 sudo touch /etc/gost/config.yaml
10 cat <<'EOF' | sudo tee /etc/gost/config.yaml > /dev/null
11 services:
12 - name: socks5-proxy-tcp
13 addr: ":33123"
14 handler:
15 type: socks5
16 auth:
17 username: "<your-custom-username>"
18 password: "<your-custom-password>"
19 listener:
20 type: tcp
21
22 - name: socks5-proxy-udp
23 addr: ":33123"
24 handler:

25 type: socks5
26 auth:
27 username: "<your-custom-username>"
28 password: "<your-custom-password>"
29 listener:
30 type: udp
31 EOF
32
33 # Configure Service
34 cat <<'EOF' | sudo tee /etc/systemd/system/gost.service > /dev/null
35 [Unit]
36 Description=GOST Proxy Service
37 After=network.target
38
39 [Service]
40 Type=simple
41 ExecStart=/usr/local/bin/gost -C /etc/gost/config.yaml
42 Restart=on-failure
43 RestartSec=5s
44
45 [Install]
46 WantedBy=multi-user.target
47 EOF
48 sudo systemctl daemon-reload
49 sudo systemctl enable gost
50 sudo systemctl start gost
51 sudo systemctl status gost
52
53 # Configure Firewall
54 sudo ufw allow from <your-bandwagon-ip> to any port 33123
55 sudo ufw deny 33123
56 sudo ufw reload
0x05 Clash 分流
不搞家庭⽹络中枢分流，仅通过本地软件分流的，可以安装下述软件。
https://github.com/clash-verge-rev/clash-verge-rev/releases
Clash 分流配置参考如下：
代码块
1 mixed-port: 33321
2 allow-lan: true
3 mode: rule
4 log-level: info

5 geodata-mode: true
6 ipv6: false
7 find-process-mode: strict
8 unified-delay: true
9 tcp-concurrent: true
10 client-fingerprint: chrome
11
12 dns:
13 enable: true
14 listen: 0.0.0.0:53
15 enhanced-mode: fake-ip
16 fake-ip-range: 198.18.0.1/16
17 fake-ip-filter:
18 - "*.lan"
19 - "*.local"
20 - "*.localhost"
21 - "dns.msftncsi.com"
22 - "www.msftncsi.com"
23 - "www.msftconnecttest.com"
24 - "+.stun.*.*"
25 - "+.stun.*.*.*"
26 - "+.stun.*.*.*.*"
27 - "+.stun.*.*.*.*.*"
28 - "lens.l.google.com"
29 - "stun.l.google.com"
30 - "time.windows.com"
31 - "time.nist.gov"
32 - "time.apple.com"
33 - "time1.cloud.tencent.com"
34 - "ntp.aliyun.com"
35 - "time.google.com"
36 - "+.ntp.*.*"
37 - "+.ntp.*.*.*"
38 - "localhost.ptlogin2.qq.com"
39 - "*.xiami.com"
40 - "+.srv.nintendo.net"
41 - "*.n.n.srv.nintendo.net"
42 - "+.stun.playstation.net"
43 - "xbox.*.*.microsoft.com"
44 - "*.*.xboxlive.com"
45 - "+.battlenet.com.cn"
46 - "+.wotgame.cn"
47 - "+.wggames.cn"
48 - "+.wowsgame.cn"
49 - "+.wargaming.net"
50 - "WORKGROUP"
51 - "*.mcdn.bilivideo.cn"

52 nameserver:
53 - https://dns.alidns.com/dns-query
54 - https://doh.pub/dns-query
55
56 proxies:
57 - name: "搬⽡⼯"
58 type: vless
59 server: <your-bandwagon-ip>
60 port: <your-vless-port>
61 uuid: <your-vless-customer-uuid>
62 network: tcp
63 udp: true
64 tls: true
65 servername: www.microsoft.com
66 reality-opts:
67 public-key: <your-reality-pubkey>
68 short-id: <your-reality-shortid>
69 client-fingerprint: chrome
70
71 - name: "AaIT 家宽"
72 type: socks5
73 server: <your-residential-ip>
74 port: 44123
75 username: <your-socks-username>
76 password: <your-socks-password>
77 udp: true
78 dialer-proxy: "搬⽡⼯"
79
80 proxy-providers:
81 airport: # 3rd airport
82 type: http
83 url: "<your-3rd-airport-subscription-url>"
84 interval: 3600
85 path: ./providers/airport.yaml
86 health-check:
87 enable: true
88 url: http://www.gstatic.com/generate_204
89 interval: 300
90
91 rule-providers:
92 custom-direct-domain:
93 type: http
94 behavior: domain
95 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Custom_Direct_Domain.yaml"
96 path: ./ruleset/custom-direct-domain.yaml

97 interval: 28800
98
99 custom-direct-classical-ip:
100 type: http
101 behavior: classical
102 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Custom_Direct_Classical_IP.yaml"
103 path: ./ruleset/custom-direct-classical-ip.yaml
104 interval: 28800
105
106 custom-proxy-domain:
107 type: http
108 behavior: domain
109 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Custom_Proxy_Domain.yaml"
110 path: ./ruleset/custom-proxy-domain.yaml
111 interval: 28800
112
113 custom-proxy-classical-ip:
114 type: http
115 behavior: classical
116 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Custom_Proxy_Classical_IP.yaml"
117 path: ./ruleset/custom-proxy-classical-ip.yaml
118 interval: 28800
119
120 steam-cdn:
121 type: http
122 behavior: classical
123 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Steam_CDN_Classical.yaml"
124 path: ./ruleset/steam-cdn.yaml
125 interval: 28800
126
127 custom-port-direct:
128 type: http
129 behavior: classical
130 url:
"https://testingcf.jsdelivr.net/gh/Aethersailor/Custom_OpenClash_Rules@main/rul
e/Custom_Port_Direct.yaml"
131 path: ./ruleset/custom-port-direct.yaml
132 interval: 28800
133

134 proxy-groups:
135 # ---------- 核⼼出⼝ ----------
136 - name: "🌏 国外出⼝"
137 type: select
138 proxies:
139 - "搬⽡⼯"
140 - "AaIT 家宽"
141 - "airport"
142 - DIRECT
143
144 - name: "🏠 国内出⼝"
145 type: select
146 proxies:
147 - DIRECT
148
149 - name: "airport"
150 type: url-test
151 use:
152 - airport
153 url: http://www.gstatic.com/generate_204
154 interval: 300
155
156 # ---------- AI 服务 ----------
157 - name: "🤖 AI服务"
158 type: select
159 proxies:
160 - "AaIT 家宽"
161 - "搬⽡⼯"
162 - "airport"
163 - "🌏 国外出⼝"
164
165 # ---------- 社交 / 通讯 ----------
166 - name: "💬 即时通讯"
167 type: select
168 proxies:
169 - "🌏 国外出⼝"
170 - "搬⽡⼯"
171 - "AaIT 家宽"
172 - "airport"
173 - "🏠 国内出⼝"
174
175 - name: "🌐 社交媒体"
176 type: select
177 proxies:
178 - "🌏 国外出⼝"
179 - "搬⽡⼯"
180 - "AaIT 家宽"

181 - "airport"
182 - "🏠 国内出⼝"
183
184 # ---------- 开发 / ⼯具 ----------
185 - name: "🚀 GitHub"
186 type: select
187 proxies:
188 - "🌏 国外出⼝"
189 - "搬⽡⼯"
190 - "AaIT 家宽"
191 - "airport"
192 - "🏠 国内出⼝"
193
194 - name: "🚀 测速⼯具"
195 type: select
196 proxies:
197 - "🏠 国内出⼝"
198 - "🌏 国外出⼝"
199 - "搬⽡⼯"
200 - "AaIT 家宽"
201 - "airport"
202
203 # ---------- 流媒体 ----------
204 - name: "📹 YouTube"
205 type: select
206 proxies:
207 - "🌏 国外出⼝"
208 - "AaIT 家宽"
209 - "搬⽡⼯"
210 - "airport"
211
212 - name: "🎶 TikTok"
213 type: select
214 proxies:
215 - "AaIT 家宽"
216 - "🌏 国外出⼝"
217 - "搬⽡⼯"
218 - "airport"
219
220 - name: "🎥 Netflix"
221 type: select
222 proxies:
223 - "AaIT 家宽"
224 - "🌏 国外出⼝"
225 - "搬⽡⼯"
226 - "airport"
227

228 - name: "🎥 DisneyPlus"
229 type: select
230 proxies:
231 - "AaIT 家宽"
232 - "🌏 国外出⼝"
233 - "搬⽡⼯"
234 - "airport"
235
236 - name: "🎥 HBO"
237 type: select
238 proxies:
239 - "AaIT 家宽"
240 - "🌏 国外出⼝"
241 - "搬⽡⼯"
242 - "airport"
243
244 - name: "🎥 PrimeVideo"
245 type: select
246 proxies:
247 - "AaIT 家宽"
248 - "🌏 国外出⼝"
249 - "搬⽡⼯"
250 - "airport"
251
252 - name: "🎥 AppleTV+"
253 type: select
254 proxies:
255 - "AaIT 家宽"
256 - "🌏 国外出⼝"
257 - "搬⽡⼯"
258 - "airport"
259 - "🏠 国内出⼝"
260
261 - name: "🎻 Spotify"
262 type: select
263 proxies:
264 - "AaIT 家宽"
265 - "🌏 国外出⼝"
266 - "搬⽡⼯"
267 - "airport"
268 - "🏠 国内出⼝"
269
270 - name: "🌎 国外媒体"
271 type: select
272 proxies:
273 - "🌏 国外出⼝"
274 - "搬⽡⼯"

275 - "AaIT 家宽"
276 - "airport"
277
278 # ---------- 电商 ----------
279 - name: "🛒 国外电商"
280 type: select
281 proxies:
282 - "🌏 国外出⼝"
283 - "搬⽡⼯"
284 - "AaIT 家宽"
285 - "airport"
286 - "🏠 国内出⼝"
287
288 # ---------- ⼤⼚服务 ----------
289 - name: "📢 ⾕歌FCM"
290 type: select
291 proxies:
292 - "🌏 国外出⼝"
293 - "搬⽡⼯"
294 - "AaIT 家宽"
295 - "airport"
296
297 - name: "🇬 ⾕歌服务"
298 type: select
299 proxies:
300 - "🌏 国外出⼝"
301 - "搬⽡⼯"
302 - "AaIT 家宽"
303 - "airport"
304
305 - name: "🍎 苹果服务"
306 type: select
307 proxies:
308 - "🏠 国内出⼝"
309 - "🌏 国外出⼝"
310 - "搬⽡⼯"
311 - "AaIT 家宽"
312 - "airport"
313
314 - name: "Ⓜ 微软服务"
315 type: select
316 proxies:
317 - "🏠 国内出⼝"
318 - "🌏 国外出⼝"
319 - "搬⽡⼯"
320 - "AaIT 家宽"
321 - "airport"

322
323 # ---------- 游戏 ----------
324 - name: "🎮 游戏平台"
325 type: select
326 proxies:
327 - "🏠 国内出⼝"
328 - "🌏 国外出⼝"
329 - "搬⽡⼯"
330 - "AaIT 家宽"
331 - "airport"
332
333 - name: "🎮 Steam"
334 type: select
335 proxies:
336 - "🏠 国内出⼝"
337 - "🌏 国外出⼝"
338 - "搬⽡⼯"
339 - "AaIT 家宽"
340 - "airport"
341
342 # ---------- 兜底 ----------
343 - name: "🐟 漏⽹之⻥"
344 type: select
345 proxies:
346 - "🌏 国外出⼝"
347 - "🏠 国内出⼝"
348 - "搬⽡⼯"
349 - "AaIT 家宽"
350 - "airport"
351
352 - name: "🔀 ⾮标端⼝"
353 type: select
354 proxies:
355 - "🐟 漏⽹之⻥"
356 - "🏠 国内出⼝"
357
358 # ===== 分流规则（按 convert_config.ini 顺序）=====
359 rules:
360 # ----- 本地地址和域名直连 -----
361 - GEOSITE,private,🏠 国内出⼝
362 - GEOIP,private,🏠 国内出⼝,no-resolve
363
364 # ----- 项⽬⾃定义直连规则 -----
365 - RULE-SET,custom-direct-domain,🏠 国内出⼝
366 - RULE-SET,custom-direct-classical-ip,DIRECT
367
368 # ----- 项⽬⾃定义代理规则 -----

369 - RULE-SET,custom-proxy-domain,🌏 国外出⼝
370 - RULE-SET,custom-proxy-classical-ip,🌏 国外出⼝
371
372 # ----- ⾕歌国内可⽤域名直连 -----
373 - GEOSITE,google-cn,🏠 国内出⼝
374
375 # ----- 国内游戏域名直连 -----
376 - GEOSITE,category-games@cn,🏠 国内出⼝
377
378 # ----- Steam 下载 CDN 直连 -----
379 - RULE-SET,steam-cdn,🏠 国内出⼝
380
381 # ----- 游戏平台下载直连 -----
382 - GEOSITE,category-game-platforms-download,🏠 国内出⼝
383
384 # ----- BT Tracker 直连 -----
385 - GEOSITE,category-public-tracker,🏠 国内出⼝
386
387 # ----- 即时通讯（Telegram/WhatsApp/Line 等）-----
388 - GEOSITE,category-communication,💬 即时通讯
389
390 # ----- 社交媒体（Twitter/Facebook/Instagram 等）-----
391 - GEOSITE,category-social-media-!cn,🌐 社交媒体
392
393 # ----- AI 服务（Claude 精细规则优先，防泄漏）-----
394 - DOMAIN-SUFFIX,anthropic.com,🤖 AI服务
395 - DOMAIN-SUFFIX,claude.ai,🤖 AI服务
396 - DOMAIN-SUFFIX,claudeusercontent.com,🤖 AI服务
397 - DOMAIN-SUFFIX,claude-api.com,🤖 AI服务
398 - DOMAIN-SUFFIX,claudecontentmoderation.com,🤖 AI服务
399 - DOMAIN-KEYWORD,anthropic,🤖 AI服务
400 - DOMAIN-KEYWORD,claude,🤖 AI服务
401 - GEOSITE,openai,🤖 AI服务
402 - GEOSITE,category-ai-!cn,🤖 AI服务
403
404 # ----- GitHub -----
405 - GEOSITE,github,🚀 GitHub
406
407 # ----- 测速⼯具 -----
408 - GEOSITE,category-speedtest,🚀 测速⼯具
409
410 # ----- Steam -----
411 - GEOSITE,steam,🎮 Steam
412
413 # ----- 流媒体 -----
414 - GEOSITE,youtube,📹 YouTube
415 - GEOSITE,apple-tvplus,🎥 AppleTV+

416 - GEOSITE,tiktok,🎶 TikTok
417 - GEOSITE,netflix,🎥 Netflix
418 - GEOSITE,disney,🎥 DisneyPlus
419 - GEOSITE,hbo,🎥 HBO
420 - GEOSITE,primevideo,🎥 PrimeVideo
421 - GEOSITE,spotify,🎻 Spotify
422
423 # ----- ⼤⼚服务 -----
424 - GEOSITE,apple,🍎 苹果服务
425 - GEOSITE,microsoft,Ⓜ 微软服务
426 - GEOSITE,googlefcm,📢 ⾕歌FCM
427 - GEOSITE,google,🇬 ⾕歌服务
428
429 # ----- 游戏平台 -----
430 - GEOSITE,category-games,🎮 游戏平台
431
432 # ----- 国外媒体 / 电商 -----
433 - GEOSITE,category-entertainment,🌎 国外媒体
434 - GEOSITE,category-ecommerce,🛒 国外电商
435
436 # ----- GFW 列表⾛国外出⼝ -----
437 - GEOSITE,gfw,🌏 国外出⼝
438
439 # ----- GEOIP 补充 -----
440 - GEOIP,telegram,💬 即时通讯,no-resolve
441 - GEOIP,twitter,🌐 社交媒体,no-resolve
442 - GEOIP,facebook,🌐 社交媒体,no-resolve
443 - GEOIP,google,🇬 ⾕歌服务,no-resolve
444 - GEOIP,netflix,🎥 Netflix,no-resolve
445
446 # ----- 绕过中国⼤陆 -----
447 - GEOSITE,cn,🏠 国内出⼝
448 - GEOIP,cn,🏠 国内出⼝,no-resolve
449
450 # ----- ⾮标端⼝（PT/BT 优化）-----
451 - RULE-SET,custom-port-direct,🔀 ⾮标端⼝
452
453 # ----- 漏⽹之⻥ -----
454 - MATCH,🐟 漏⽹之⻥
0x06 家庭⽹络中枢
（待补充）
https://item.jd.com/100213984970.html

https://github.com/Aethersailor/Custom_OpenClash_Rules/wiki/OpenClash-
%E8%AE%BE%E7%BD%AE%E6%96%B9%E6%A1%88
0x07 Claude
（待补充）
0x0701 注册 Claude
接码平台 https://hero-sms.com/cn
0x0702 配置 Claude
.zshrc
1 ## RUN WITH PROXY SRART
2 run_with_proxy() {
3 (
4 cmd=$1; shift
5 export http_proxy="http://127.0.0.1:33000"
6 export https_proxy="http://127.0.0.1:33000"
7 export all_proxy="socks5h://127.0.0.1:33000"
8 export HTTP_PROXY="http://127.0.0.1:33000"
9 export HTTPS_PROXY="http://127.0.0.1:33000"
10 export ALL_PROXY="socks5h://127.0.0.1:33000"
11 export
no_proxy="localhost,127.0.0.1,::1,.byted.org,.bytedance.net,.bytedance.com,.byt
eintl.com,.byteintl.net,.volces.com,.snssdk.com,.bytedance-
boe.net,.bytedance.org,.feishu.cn,.feishu.net,.larksuite.com,.larkoffice.com"
12 export NO_PROXY="$no_proxy"
13 command "$cmd" "$@"
14 )
15 }
16
17 alias claude="run_with_proxy claude"
18 alias codex="run_with_proxy codex"
19 ## RUN WITH PROXY END
0x08 Codex
（待补充）
GPT 系列模型以其冷峻、⼀丝不苟的精神，稳稳地接住了我。
https://github.com/openai/codex-plugin-cc

这个插件可以在 Claude Code 内召唤 Codex 来帮你 review ⼯作区改动，或者是紧急救援。
挺适合让他来 review Claude Code 的代码修改。
购买⽅式同 Claude。
