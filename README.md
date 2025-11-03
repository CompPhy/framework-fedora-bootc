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

- Branch: `release-42` — used to maintain Fedora 42 specific CI and image tags.
- `main` — continues to receive normal development and will be moved to newer Fedora versions (for example, PR #20 moves the project to Fedora 43).

Tagging behavior performed by the build workflow:
- When publishing from `main` the build pushes both the `latest` and `42` image tags (plus a SHA-tagged image). This preserves backwards compatibility for users who pull the `42` tag while `main` transitions.
- When publishing from `release-42` the build pushes the `42` tag (plus a SHA tag).

Renovate
- Renovate is configured to create dependency update PRs against both `main` and `release-42` so the release branch will continue to receive automated updates for upstream dependency changes. See `renovate.json` for details.

Creating a release branch and PR
1. Create and push the release branch locally from the current working tree:

```bash
git checkout -b release-42
git add .github/workflows/build.yaml renovate.json
git commit -m "CI: support release-42 (main tags latest+42); add release-42 to renovate baseBranches)"
git push -u origin release-42
```

2. Create a draft PR (recommended) from `release-42` into `main` (via web UI or using `gh`):

```bash
gh pr create --title "WIP: release-42 - keep F42 tags and add Renovate support for release branch" \
    --body-file /tmp/release-42-pr.md --base main --head release-42 --draft
```

3. Monitor the CI runs and GHCR/tags to verify images were pushed as intended.

When it's time to retire the `release-42` branch (for example, after `main` has fully migrated to Fedora 43), remove the special-case tagging from the workflow and delete the branch.
