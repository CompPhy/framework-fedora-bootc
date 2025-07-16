FROM quay.io/fedora/fedora-bootc:42
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint