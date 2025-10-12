FROM quay.io/fedora/fedora-bootc:42@sha256:64bd8a9b2c7cd88c86f3c8a9d67da14103bcb37e725e0c5a5ff0d90af674edc9 AS builder
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y --exclude rootfiles @kde-desktop-environment @development-tools @container-management @system-tools @games; dnf clean all
RUN systemctl disable abrtd atd mcelog
RUN systemctl set-default graphical.target
RUN ln -snf ../usr/share/zoneinfo/America/New_York /etc/localtime
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint

FROM builder
COPY files/vscode.repo /etc/yum.repos.d/
RUN dnf install -y code firefox terminator && dnf clean all
RUN dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN dnf config-manager setopt fedora-cisco-openh264.enabled=1
RUN dnf install -y steam && dnf clean all
RUN bootc container lint

