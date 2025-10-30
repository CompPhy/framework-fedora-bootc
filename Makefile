OCI_IMAGE ?= ghcr.io/compphy/framework-fedora-bootc:latest
DISK_TYPE ?= raw
ROOTFS ?= ext4
ARCH ?= amd64
# Use upsteam build:
# BIB_IMAGE ?= quay.io/centos-bootc/bootc-image-builder:latest
# Use local build:
BIB_IMAGE ?= localhost/bootc-image-builder:latest

# See https://github.com/osbuild/bootc-image-builder
.PHONY: disk-image
disk-image:
	podman build -t framework-fedora-bootc $(CURDIR)
	podman build -t bootc-image-builder $(CURDIR)/bootc-image-builder
	mkdir -p ./output
	mkdir -p /var/lib/containers/storage
	sed -e 's;@@IMAGE@@;$(OCI_IMAGE);g' config.toml.in > config.toml
	podman pull $(OCI_IMAGE)
	podman run \
		--rm \
		-it \
		--privileged \
		--security-opt label=type:unconfined_t \
		-v ./config.toml:/config.toml:ro \
		-v ./output:/output \
		-v /var/lib/containers/storage:/var/lib/containers/storage \
		$(BIB_IMAGE) \
		--target-arch $(ARCH) \
		--type $(DISK_TYPE) \
		--rootfs $(ROOTFS) \
		--use-librepo \
		localhost/framework-fedora-bootc:latest