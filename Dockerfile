FROM alpine:latest


ENV LANG C.UTF-8
ENV TZ 'Asia/Shanghai'

RUN apk --update upgrade \
	&& apk --update add tzdata \
	&& ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone
    
FROM node:12
RUN  git clone https://github.com/UnsignedInt8/leavexchat-bot.git /leavexchat-bot \
	&& cd /leavexchat-bot \
	&& npm i \
	&& npm run build

WORKDIR /leavexchat-bot
ADD start.sh .

CMD /bin/sh /start.sh