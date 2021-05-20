FROM node:slim

LABEL MAINTAINER="zhangxiong@wondersgroup.com"

RUN adduser --disabled-password --gecos '' --shell /bin/bash --home /sinopia sinopia && \
  adduser sinopia sudo && \
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  mkdir -vp /opt/sinopia/storage


WORKDIR /opt/sinopia
RUN npm install js-yaml sinopia && \
    chown -R sinopia:sinopia /opt/sinopia

USER sinopia

ADD --chown=sinopia:sinopia /config.yaml /tmp/config.yaml
ADD --chown=sinopia:sinopia /start.sh /opt/sinopia/start.sh

ENTRYPOINT ["sh", "/opt/sinopia/start.sh"]
EXPOSE 4873
VOLUME /opt/sinopia
