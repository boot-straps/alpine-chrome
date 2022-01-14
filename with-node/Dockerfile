FROM bootstraps/alpine-chrome

USER root
RUN apk add --no-cache tini make gcc g++ python3 git nodejs nodejs-npm yarn \
    && ln -sf python3 /usr/bin/python

USER chrome

ENTRYPOINT ["tini", "--"]
