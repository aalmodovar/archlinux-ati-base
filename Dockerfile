FROM pritunl/archlinux
MAINTAINER Antonio Almodóvar <aalmodovar@gmail.com>

RUN pacman -S --needed --noconfirm base-devel wget
# Set no compression
RUN sed 's/\.pkg\.tar\.xz/\.pkg\.tar/g' < /etc/makepkg.conf > makepkg2.conf && mv makepkg2.conf /etc/makepkg.conf

# no sudo password for users in wheel group
RUN sed -i 's/# %wheel ALL=(ALL) NOPASSWD: ALL/%wheel ALL=(ALL) NOPASSWD: ALL/g' /etc/sudoers

RUN useradd -m -G wheel tonino

RUN mkdir /tmp/catalyst-utils && chown tonino /tmp/catalyst-utils

USER tonino
RUN cd /tmp/catalyst-utils && wget https://aur.archlinux.org/cgit/aur.git/snapshot/catalyst-utils.tar.gz && \
	tar -xvzf catalyst-utils.tar.gz && \
	cd catalyst-utils && \
	makepkg --noconfirm -rsi && \
	cd .. && rm -rf catalyst-utils

# Clean up
RUN sudo pacman -Scc --noconfirm

