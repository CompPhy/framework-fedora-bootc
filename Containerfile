FROM quay.io/fedora/fedora-bootc:43@sha256:cb46baca2c8eb2413a9576edc7b8f0ae0453bef75f0a8c1ef7f83286ac4ab173
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint