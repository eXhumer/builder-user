FROM node:18-alpine

RUN apk add --no-cache rsync

RUN npm i --location=global pnpm@8.5.1

RUN addgroup -S buildgroup && adduser -S builduser -G buildgroup

COPY ./entrypoint.sh /home/builduser/entrypoint.sh

RUN chown builduser:buildgroup /home/builduser/entrypoint.sh
RUN chmod a+x /home/builduser/entrypoint.sh

USER builduser

ENTRYPOINT [ "/home/builduser/entrypoint.sh" ]
