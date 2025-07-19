FROM quay.io/fedora/fedora-bootc:42@sha256:ebe9cd10da14dd2eef1763669021755b2df5d9e4dbf78285576cd7664a73ad15
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint