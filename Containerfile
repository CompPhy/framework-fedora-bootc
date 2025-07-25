FROM quay.io/fedora/fedora-bootc:42@sha256:d781f0558d6d7173110bc3d56d343bf30f8ce3f2c168bd03c68c2214ccf6b12c
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint