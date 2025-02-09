### Container to build and deploy Nvidia drivers to host

https://github.com/NVIDIA/gpu-driver-container

Modified for Fedora CoreOS

https://gitlab.com/container-toolkit-fcos/driver

### Manual build

```bash
git clone https://github.com/NVIDIA/gpu-driver-container.git
cd gpu-driver-container/fedora

TARGETARCH=$(arch)
TARGETARCH=${TARGETARCH/x86_64/amd64} && TARGETARCH=${TARGETARCH/aarch64/arm64}
DRIVER_VERSION=565.77
KERNEL_TYPE=kernel-open
FEDORA_VERSION=41
BASE_URL=https://us.download.nvidia.com/XFree86/Linux-$(arch)
TAG=ghcr.io/randomcoww/nvidia-driver:$DRIVER_VERSION-f$FEDORA_VERSION-$TARGETARCH

podman build \
  --arch $TARGETARCH \
  --build-arg TARGETARCH=$TARGETARCH \
  --build-arg FEDORA_VERSION=$FEDORA_VERSION \
  --build-arg BASE_URL=$BASE_URL \
  --build-arg DRIVER_VERSION=$DRIVER_VERSION \
  --build-arg KERNEL_TYPE=$KERNEL_TYPE \
  -f Dockerfile \
  -t $TAG

podman push $TAG
```

Install to host

```bash
sudo podman run -it --rm --privileged --pid=host --net=host \
  -v /run/nvidia:/run/nvidia:shared \
  -v /var/log:/var/log \
  $TAG
```
