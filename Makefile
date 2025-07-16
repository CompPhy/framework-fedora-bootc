OCI_IMAGE ?= ghcr.io/compphy/framework-fedora-bootc:da09f99b16f30cecd95ffc07d8123a46891d38c3 
DISK_TYPE ?= anaconda-iso
ROOTFS ?= xfs
ARCH ?= amd64
BIB_IMAGE ?= quay.io/centos-bootc/bootc-image-builder:latest

# See https://github.com/osbuild/bootc-image-builder
.PHONY: disk-image
disk-image:
	mkdir -p ./output
	mkdir -p /var/lib/containers/storage
	sed -e 's;@@IMAGE@@;$(OCI_IMAGE);g' config.toml.in > config.toml
	podman pull $(OCI_IMAGE)
	podman run \
		--rm \
		-it \
		--privileged \
		--pull=newer \
		--security-opt label=type:unconfined_t \
		-v ./config.toml:/config.toml:ro \
		-v ./output:/output \
		-v /var/lib/containers/storage:/var/lib/containers/storage \
		$(BIB_IMAGE) \
		--target-arch $(ARCH) \
		--type $(DISK_TYPE) \
		--rootfs $(ROOTFS) \
		--use-librepo \
		$(OCI_IMAGE)