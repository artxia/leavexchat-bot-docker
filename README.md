# leavexchat-bot-docker

群晖docker搭建wechaty + telegram bot，将微信消息转发至tg

[![Powered by Wechaty](https://img.shields.io/badge/Powered%20By-Wechaty-brightgreen.svg)](https://wechaty.js.org)

```
docker run -d --name leavexchat \
 -v ./config/config.json:/config.json \
 artxia/leavexchat-bot-docker
```
运行成功后，在 telegram bot 输入 `/start` 开始

原项目：[leavexchat-bot](https://github.com/UnsignedInt8/leavexchat-bot)
