FROM quay.io/fedora/fedora-bootc:42@sha256:271a95db962d4272425a00d22f1f47c4861429d1cffc138b92a24af9cbc65309
RUN dnf install -y plasma-desktop && dnf clean all
RUN systemctl set-default graphical.target
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint