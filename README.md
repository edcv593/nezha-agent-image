# nezha-agent-image

把官方 [nezhahq/agent](https://github.com/nezhahq/agent) 的二进制（官方只发二进制，不发 Docker 镜像）
打包成多架构容器镜像，推送到 GitHub Container Registry。

- `linux/amd64` 和 `linux/arm64`
- 每周自动跟上游最新版重建
- 也可手动触发（Actions → Run workflow）

## 使用

```yaml
services:
  nezha-agent:
    image: ghcr.io/<你的用户名>/nezha-agent-image:latest
    container_name: nezha-agent
    restart: always
    network_mode: host
    pid: host
    volumes:
      - /opt/nezha-agent/config.yml:/config.yml:ro
      - /etc/os-release:/etc/os-release:ro
    command: ["-c", "/config.yml"]
```

`network_mode: host` 用于读取真实网卡流量，`pid: host` 用于读取宿主机进程数。

## config.yml 示例

```yaml
client_secret: <从面板「服务器 → 安装命令」复制>
server: nezha.625426.xyz:443
tls: true
disable_auto_update: false
disable_command_execute: false
disable_force_update: false
disable_nat: false
disable_send_query: false
gpu: false
insecure_tls: false
report_delay: 3
uuid: <随机唯一字符串>
```

## 首次使用前

必须把 Package 设为公开，否则匿名拉取会返回 `denied`：

Repo → Packages → 进入包 → Package settings → Change visibility → Public

## 为什么需要这个仓库

Nezha 官方只发布 agent 的**二进制**（`nezha-agent_linux_amd64.tar.gz` 等），
没有官方 Docker 镜像。第三方镜像无法验证构建过程，而 Agent 以 root + host 网络运行，
风险不对称，因此这里用官方二进制自行构建。
