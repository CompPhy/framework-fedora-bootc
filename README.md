Inspired by:
* https://github.com/nzwulfin/cicd-bootc
* https://github.com/vrothberg/fedora-bootc-workstation

This will be a CI/CD pipeline for building Fedora bootc on Framework laptop hardware.

Included features:
* Plasma Desktop
* WIFI driver and tools
* Podman Desktop
* Basic office tools
* Developer tools

How to build ISO installation media
============================
**Optional:  Edit Makefile to set DISK_TYPE, ROOTFS, and ARCH as needed.**

```
git clone https://github.com/CompPhy/framework-fedora-bootc
sudo dnf install make podman iptables
# Fix for this issue when using WSL:  https://github.com/containers/podman/issues/25201
sudo vim /etc/containers/containers.conf
    [network]
    firewall_driver="iptables"
# Verify the image hash you want to pull in the Makefile.
sudo make disk-image
```
