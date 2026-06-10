结论：在你没有可信美国住址/亲友可以长期放设备的前提下，**先选服务，不建议现在“自己搭建”**。但服务要选“独享、固定、真实家宽/住宅宽带出口”的 IP 服务，不要选 Claude API 中转站、共享机场、便宜轮换住宅代理池。

更准确地说：

| 方案                                                         |         适合你吗 | 判断                                           |
| ------------------------------------------------------------ | ---------------: | ---------------------------------------------- |
| 美国亲友家里放 GL.iNet / 树莓派，用 Tailscale/WireGuard 出口 |   最优，但门槛高 | 这才是真正“自建纯家宽”。有美国物理宽带才值得做 |
| VIRCS/AaIT/AaITR 这类“美国住宅宽带 VPS/SOCKS”                |       当前最现实 | 先月付试用，验证 IP 质量，不要年付             |
| IPRoyal/Decodo/Webshare 这类 Static Residential / ISP Proxy  | 可测试，不是首选 | 很多是“ISP IP + 机房承载”，不等于真实家庭宽带  |
| 普通 VPS / 云服务器 IP                                       | 不推荐做最终出口 | 可以做中转，不能解决住宅 IP 纯净度             |
| Claude API/Claude Code 中转站、低价共享服务                  |       明确不推荐 | 有账号、模型替换、日志泄露、封禁风险           |

我的推荐路径：

1. **短期**：买一个月“独享静态美国住宅宽带 IP/VPS/SOCKS”服务测试，优先选能明确说明 ASN、运营商、独享、不轮换、非共享的服务。你本地资料里 AaIT/AaITR/VIRCS 这类，比普通住宅代理池更贴近需求。
2. **中期**：用 CN2/GIA VPS 或稳定机场做前置中转，住宅 IP 只做落地出口。你的资料里这个思路是对的。
3. **长期**：如果 Claude Code 是刚需、使用频率高、代码敏感，最好找美国可信环境自建 Tailscale/WireGuard Exit Node。Tailscale 和 GL.iNet 官方文档都支持这种“流量从家里出口”的模式。

关键风险我必须说清楚：Anthropic 官方写明 Claude 会用 IP 和其他信号判断国家/地区，用于条款合规和反滥用；Consumer Terms 也要求遵守 Supported Regions Policy，并禁止绕过保护措施。也就是说，**美国住宅 IP 只能降低网络侧误伤概率，不能保证账号安全，也不能把不合规使用变成合规使用**。

购买服务前的验收标准：

- `ipinfo.io` 看 ASN/Org 是否是 AT&T / Comcast / Frontier / Spectrum 这类住宅/ISP，而不是 hosting/datacenter。
- Scamalytics / IPQS / Ping0 交叉查，Fraud Score 低、无 VPN/Proxy/Hosting 标记。
- DNS 不泄露，IPv6 禁用或完全走代理。
- 浏览器、终端、Claude Code 请求都必须同一个出口。
- 不用智能分流碰运气，Claude 相关域名优先级最高。
- 月付试 7 天，正常强度使用，不要一上来高并发、频繁换 IP、共享账号。

我参考的资料包括你本地的 [Claude Code 网络风险整理](</Users/a86198/Desktop/IP-USA/reference/IP/我的吸毒之路： 如何体验 Claude Code？.md:58>)、[住宅 IP 链式代理教程](/Users/a86198/Desktop/IP-USA/reference/IP/别再买机房伪装IP了！保姆级教程：手把手教你搭建真正的美国家庭宽带住宅IP.md:29)、[Claude IP 稳定指南](/Users/a86198/Desktop/IP-USA/reference/IP/claude-IP.md:20)，以及 Anthropic [Supported countries](https://www.anthropic.com/supported-countries)、[位置使用说明](https://privacy.claude.com/en/articles/11186740-does-claude-use-my-location)、[Consumer Terms](https://www.anthropic.com/legal/consumer-terms)、Tailscale [Exit Node](https://tailscale.com/docs/features/exit-nodes/how-to/setup)、GL.iNet [WireGuard Home Server](https://docs.gl-inet.com/router/en/4/tutorials/build_your_own_wireguard_home_server_with_two_glinet_routers/)、IPRoyal/Decodo/Webshare 当前价格页，以及 FBI/Bitsight 对住宅代理滥用风险的说明。
