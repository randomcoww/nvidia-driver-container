ARG BASE_IMAGE
FROM $BASE_IMAGE

COPY drm.patch .

RUN set -x \
  \
  && patch /usr/local/bin/nvidia-driver drm.patch \
  && rm drm.patch