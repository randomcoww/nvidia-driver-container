ARG BASE_IMAGE
FROM $BASE_IMAGE

COPY nvidia-driver-drm /usr/local/bin

ENTRYPOINT ["nvidia-driver-drm", "init"]