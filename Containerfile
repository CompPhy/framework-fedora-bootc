FROM quay.io/fedora/fedora-silverblue:42
RUN dnf -y install mkpasswd open-vm-tools-desktop && dnf clean all
RUN pass=$(mkpasswd --method=SHA-512 --rounds=4096 fedora) && useradd -m -G wheel fedora -p $pass
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint