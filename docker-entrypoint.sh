#!/bin/bash

set -eu

# docker run parameters for pulseaudio
# --group-add "$(getent group audio | cut -d: -f3)"
# -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native"
# -v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native"
# -v "${HOME}/.config/pulse/cookie:/tmp/pulseaudio_cookie"
PULSEAUDIO_COOKIE_TMP_MOUNT_PATH=/tmp/pulseaudio_cookie

USER_NAME=user
FIREFOX_PROFILE_NAME=user

useradd -u ${HOST_UID} -o -m ${USER_NAME}
groupmod -g ${HOST_GID} ${USER_NAME}

chown -R ${USER_NAME}:${USER_NAME} /work

mv "${PULSEAUDIO_COOKIE_TMP_MOUNT_PATH}" /home/${USER_NAME}/.config/pulse/cookie

if [ -z "$(ls -A /work)" ]; then
  gosu ${USER_NAME} firefox -headless -CreateProfile "${FIREFOX_PROFILE_NAME} /work"
fi

gosu ${USER_NAME} firefox --profile "/work"

