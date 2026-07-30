FROM quay.io/fedora/fedora-bootc:44@sha256:fb71f099f40360b5e1e2e78e845ccf4f0f80fbe1b09de721d8954cddb89ee9c4 AS builder
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade -y --refresh
RUN dnf install -y --exclude rootfiles @kde-desktop-environment @development-tools @container-management @system-tools @games && dnf clean all
RUN systemctl disable abrtd atd mcelog
RUN systemctl set-default graphical.target
RUN ln -snf ../usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint

FROM builder
COPY files/vscode.repo /etc/yum.repos.d/
RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN dnf config-manager setopt fedora-cisco-openh264.enabled=1
RUN dnf install -y code firefox terminator wireguard-tools steam solaar && dnf clean all
RUN bootc container lint
