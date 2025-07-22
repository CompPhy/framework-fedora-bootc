FROM quay.io/fedora/fedora-bootc:42@sha256:4807abf46898e5074a2dcf8edd8cab918b081985a07e1b4dd414a95e8cec3214
# https://bugzilla.redhat.com/show_bug.cgi?id=2381864
RUN dnf upgrade --enablerepo=updates-testing --refresh --advisory=FEDORA-2025-77e737a366
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint