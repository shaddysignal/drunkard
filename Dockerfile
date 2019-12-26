FROM alpine:3.11

COPY _build/prod/rel/drunkard/bin/drunkard /bin/drunkrad

EXPOSE 4000

ENTRYPOINT [ "drunkard" ]
CMD [ "start" ]