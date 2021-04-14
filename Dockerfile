FROM node:12-slim as build

RUN apt-get update && apt-get install --yes git curl \
    && git clone https://github.com/UnsignedInt8/leavexchat-bot.git /leavexchat-bot \
    && cd /leavexchat-bot \
    && sed -i 's/"wechaty": "^0.59.8"/"wechaty": "^0.60.3"/g' package.json \
    && sed -i 's/"wechaty-puppet-wechat": "^0.27.0"/"wechaty-puppet-wechat": "^0.28.1"/g' package.json \
    && npm i \
    && npm run build \
    && rm -fr /tmp/* ~/.npm

FROM node:12-slim

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
     libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
     libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
     libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
     libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 libnss3 \
     libgbm-dev libxshmfence-dev fonts-liberation libappindicator1 lsb-release xdg-utils \
    && apt-get purge --auto-remove \
    && rm -rf /tmp/* /var/lib/apt/lists/*

ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

COPY --from=build /leavexchat-bot/package.json ./package.json
COPY --from=build /leavexchat-bot/node_modules/ ./node_modules/
COPY --from=build /leavexchat-bot/build/main/ ./build/main/

ADD start.sh /start.sh

RUN chmod +x /start.sh

ENTRYPOINT ["/bin/sh", "start.sh"]
