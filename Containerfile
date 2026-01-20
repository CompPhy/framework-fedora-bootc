FROM quay.io/fedora/fedora-bootc:43@sha256:d80f2c08a48e1fdf9a8cd5863ee979456b5bb232a8e40d70aa984f69c3d50d55 AS builder
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade -y --refresh
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

