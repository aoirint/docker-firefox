FROM ubuntu:bionic

# https://packages.ubuntu.com/ja/bionic-updates/firefox
ARG FIREFOX_VERSION=80.0.1+build1-0ubuntu0.18.04.1
# https://packages.ubuntu.com/ja/bionic/gosu
ARG GOSU_VERSION=1.10-1
# https://packages.ubuntu.com/ja/bionic-updates/fonts-noto-cjk
ARG NOTO_CJK_VERSION=1:20190409+repack1-0ubuntu0.18.04
# https://packages.ubuntu.com/ja/bionic-updates/pulseaudio
ARG PULSEAUDIO_VERSION=1:11.1-1ubuntu7.10

RUN apt update -qq \
  && apt upgrade -y \
  && apt install -y --no-install-recommends \
    firefox=${FIREFOX_VERSION} \
    gosu=${GOSU_VERSION} \
    fonts-noto-cjk=${NOTO_CJK_VERSION} \
    pulseaudio=${PULSEAUDIO_VERSION}

WORKDIR /work

ADD docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "/usr/local/bin/docker-entrypoint.sh" ]

