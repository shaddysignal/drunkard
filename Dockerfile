FROM alpine:3.11

RUN mkdir -p /opt/local
WORKDIR /opt/local
COPY _build/ .

EXPOSE 4000

CMD [ "_build/prod/rel/drunkard/bin/drunkard", "start" ]