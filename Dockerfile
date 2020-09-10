FROM alpine:latest


ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN set -x \
    && apk --update upgrade \
    && apk --update add tzdata
    
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone
    
FROM node:12
RUN set -x \
    && npm i \
    && npm run build

WORKDIR .

ENTRYPOINT ["node", "/build/main/index.js", "-c", "/config.json"]