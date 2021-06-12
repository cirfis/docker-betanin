FROM python:3.6-alpine

RUN \
  apk add --no-cache --virtual build-dep build-base rust cargo git openssl-dev py3-greenlet py3-gevent py3-cryptography && apk add --no-cache libevent openssl curl libev libffi-dev sudo && \
  git clone https://github.com/sentriz/betanin.git /opt/betanin && \
  cd /opt/betanin && pip --no-cache-dir install -U \
  betanin -r ./requirements-docker.txt && \
  apk del build-dep

VOLUME /root/.local/share/betanin/
VOLUME /root/.config/betanin/
VOLUME /root/.config/beets/

WORKDIR /opt/betanin

ENV PYTHONUNBUFFERED=1
ENV PYTHONWARNINGS="ignore:Unverified HTTPS request"
ENV UID=0
ENV GID=0
CMD [ "./_docker_entry" ]
