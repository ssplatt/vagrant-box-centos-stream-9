#!/usr/bin/env bash
set -e

echo ":::: Running as user $(whoami) ... "
id
echo ":::: Home dir: $HOME ..."

sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

sudo yum install -y epel-release
sudo yum upgrade -y
sudo yum groupinstall -y GNOME
sudo yum install -y \
    gdm \
    firefox \
    cloud-utils-growpart \
    cloud-init \
    open-vm-tools-desktop \
    vim \
    wget \
    htop \
    gcc \
    make \
    net-tools \
    python3 \
    python3-devel \
    git \
    zlib \
    bzip2-devel \
    ncurses-devel \
    libffi-devel \
    readline-devel \
    openssl-devel \
    sqlite-devel \
    xz-devel \
    zlib-devel

sudo systemctl set-default graphical
