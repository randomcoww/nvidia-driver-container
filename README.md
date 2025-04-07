### Container to build and deploy Nvidia drivers to host

https://github.com/NVIDIA/gpu-driver-container

Modified for Fedora CoreOS

https://gitlab.com/container-toolkit-fcos/driver

### Manual build

```bash
TAG=fedora-rebased-main-25.01.21
TARGETARCH=$(arch)
TARGETARCH=${TARGETARCH/x86_64/amd64} && TARGETARCH=${TARGETARCH/aarch64/arm64}
DRIVER_VERSION=570.124.06
KERNEL_TYPE=kernel
FEDORA_VERSION=41
BASE_URL=https://us.download.nvidia.com/tesla

git clone -b $TAG https://gitlab.com/container-toolkit-fcos/driver.git
cd driver/fedora

podman build \
  --arch $TARGETARCH \
  --build-arg TARGETARCH=$TARGETARCH \
  --build-arg FEDORA_VERSION=$FEDORA_VERSION \
  --build-arg BASE_URL=$BASE_URL \
  --build-arg DRIVER_VERSION=$DRIVER_VERSION \
  --build-arg KERNEL_TYPE=$KERNEL_TYPE \
  -f Dockerfile \
  -t ghcr.io/randomcoww/nvidia-driver:v$DRIVER_VERSION-fedora$FEDORA_VERSION
```

Install to host

```bash
sudo podman run -it --rm --privileged --pid=host --net=host \
  -v /run/nvidia:/run/nvidia:shared \
  -v /var/log:/var/log \
  $TAG
```
