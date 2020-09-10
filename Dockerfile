FROM alpine:latest


ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -x \
    && apk --update upgrade \
    && apk --update add tzdata \
    && apk add --no-cache --virtual .build-deps make git \
    
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
    
FROM node:12
RUN set -x \
	&& git clone https://github.com/UnsignedInt8/leavexchat-bot.git /leavexchat-bot \
	&& cd /leavexchat-bot \
    && npm i \
    && apk del .build-deps \
    && npm run build

WORKDIR /leavexchat-bot

ENTRYPOINT ["node", "/build/main/index.js", "-c", "/config.json"]