FROM node:16-alpine

COPY build/ci/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

ARG UID
ARG GID

RUN mkdir /.npm && \
chown $UID:$GID -R /.npm

WORKDIR /app
