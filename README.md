### Container to build and deploy Nvidia drivers to host

https://github.com/NVIDIA/gpu-driver-container

Modified for Fedora CoreOS

https://gitlab.com/container-toolkit-fcos/driver

Latest release

```bash
curl -s https://gitlab.com/api/v4/projects/container-toolkit-fcos%2Fdriver/repository/tags | jq -r 'first(.[] | select(.name | endswith("-fedora"))).name'
```