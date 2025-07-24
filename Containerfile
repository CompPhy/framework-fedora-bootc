FROM quay.io/fedora/fedora-bootc:42@sha256:be629db2ab373c054d8f611a214d21b6e16ce48118068d47cb2f1f87a0e30cfa
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint