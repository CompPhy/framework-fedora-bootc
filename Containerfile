FROM quay.io/fedora/fedora-bootc:43@sha256:1b0ad598e703e0b7f01fa2c5f536b0fd44668c58ba1d74cf0240689aa538eb2d AS builder
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
RUN dnf install -y code firefox && dnf clean all
RUN bootc container lint
