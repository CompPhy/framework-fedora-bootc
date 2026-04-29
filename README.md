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
===================================
**Optional:  Edit Makefile to set DISK_TYPE, ROOTFS, and ARCH as needed.**

**This assumes you're using a Fedora WSL environment for building.  It might work different elsewhere.**

```
git clone --recurse-submodules --remote-submodules https://github.com/CompPhy/framework-fedora-bootc
sudo dnf install make podman iptables
# Fix for this issue when using WSL:  https://github.com/containers/podman/issues/25201
sudo vim /etc/containers/containers.conf
    [network]
    firewall_driver="iptables"
# Verify the image hash you want to pull in the Makefile.
sudo make disk-image
```

Release branches and tagging policy
===================================

This repository uses a small release-branch policy to continue producing older-release images while development moves forward on `main`.

- Branch: `release-*` — used to maintain older Fedora release images.
- `main` — continues to receive normal development and is the most recent major release.

Tagging behavior performed by the build workflow:
- When publishing from `main` the build pushes both the `latest` and release version tags (plus a SHA-tagged image).
- When publishing from `release-*` the build pushes the release version tag (plus a SHA tag).

Renovate
- Renovate is configured to create dependency update PRs against both `main` and `release-*` so the release branch will continue to receive automated updates for upstream dependency changes. See `renovate.json` for details.

When it's time to retire the `release-42` branch (for example, after `main` has fully migrated to Fedora 43), remove the special-case tagging from the workflow and delete the branch.
