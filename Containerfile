FROM quay.io/fedora/fedora-bootc:43@sha256:5c22db27e5e6a9bdebb5e63cb50fb1b2735663ca871ce75110e046c92913f96a AS builder
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

