FROM quay.io/fedora/fedora-bootc:42@sha256:1909326816201ef036f31186d13b94cb9c61fa39be2cc5c0680b330ad5fc7427
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint