FROM alpine:latest


ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN apk --update upgrade \
    && apk --update add tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
       libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
       libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
       libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
       libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 \
       libnss3
    
FROM node:12
RUN  git clone https://github.com/UnsignedInt8/leavexchat-bot.git /leavexchat-bot \
    && cd /leavexchat-bot \
    && npm i \
    && npm run build

WORKDIR /leavexchat-bot
ADD start.sh .

CMD /bin/sh /start.sh