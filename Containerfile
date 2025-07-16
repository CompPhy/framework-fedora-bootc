FROM quay.io/fedora/fedora-bootc:42
# mkpasswd and open-vm-tools-desktop are already part of silverblue base image.
# RUN dnf -y install mkpasswd open-vm-tools-desktop && dnf clean all
# Create user during anaconda install, instead of at image build.
# RUN pass=$(mkpasswd --method=SHA-512 --rounds=4096 fedora) && useradd -m -G wheel fedora -p $pass
RUN echo "%wheel        ALL=(ALL)       NOPASSWD: ALL" > /etc/sudoers.d/wheel-sudo
RUN bootc container lint