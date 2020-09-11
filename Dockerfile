FROM ubuntu:18.04


ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN apt-get update \
    && apt-get install -yq --no-install-recommends \
       libasound2 libatk1.0-0 libc6 libcairo2 libcups2 libdbus-1-3 \
       libexpat1 libfontconfig1 libgcc1 libgconf-2-4 libgdk-pixbuf2.0-0 libglib2.0-0 libgtk-3-0 libnspr4 \
       libpango-1.0-0 libpangocairo-1.0-0 libstdc++6 libx11-6 libx11-xcb1 libxcb1 \
       libxcomposite1 libxcursor1 libxdamage1 libxext6 libxfixes3 libxi6 libxrandr2 libxrender1 libxss1 libxtst6 libnss3 \
       fonts-liberation libappindicator1 lsb-release xdg-utils \
       apt-utils autoconf automake bash build-essential ca-certificates curl coreutils ffmpeg figlet git \
       gnupg2 jq libgconf-2-4 libtool moreutils python-dev python-dev shellcheck sudo vim wget \
    && apt-get purge --auto-remove \
    && DEBIAN_FRONTEND=noninteractive apt-get install tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata \
    && rm -rf /tmp/* /var/lib/apt/lists/*

RUN curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - \
    && apt-get update && apt-get install -y --no-install-recommends nodejs \
    && apt-get purge --auto-remove \
    && rm -rf /tmp/* /var/lib/apt/lists/*

RUN  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
       google-chrome-unstable \
    && apt-get purge --auto-remove \
    && rm -rf /tmp/* /var/lib/apt/lists/* \
    && rm -rf /usr/bin/google-chrome* /opt/google/chrome-unstable

RUN  git clone https://github.com/UnsignedInt8/leavexchat-bot.git /leavexchat-bot \
    && cd /leavexchat-bot \
    && npm i \
    && npm run build \
    && rm -fr /tmp/* ~/.npm


WORKDIR /leavexchat-bot
ADD start.sh .
RUN chmod +x /start.sh

CMD /bin/sh /start.sh