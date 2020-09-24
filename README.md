# firefox-docker
Run Firefox in Docker.

Profile data will be saved to docker volume `docker-firefox-profile`.

## Requirements
- X Window
- Pulseaudio

## Run
```sh
docker run --rm \
  -e DISPLAY \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  --group-add "$(getent group audio | cut -d: -f3)" \
  -e "PULSE_SERVER=unix:${XDG_RUNTIME_DIR}/pulse/native" \
  -v "${XDG_RUNTIME_DIR}/pulse/native/:${XDG_RUNTIME_DIR}/pulse/native" \
  -v "${HOME}/.config/pulse/cookie:/tmp/pulseaudio_cookie" \
  -e "HOST_UID=$(id -u $USER)" \
  -e "HOST_GID=$(id -g $USER)" \
  -v "docker-firefox-profile:/work" \
  -d \
  aoirint/firefox
```
