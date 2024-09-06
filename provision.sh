#!/usr/bin/env bash
set -e

echo ":::: Running as user $(whoami) ... "
id
echo ":::: Home dir: $HOME ..."

sestatus=$(sudo getenforce)
echo "$sestatus"
if [[ "$sestatus" != "Disabled" ]]; then
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
fi

sudo systemctl stop firewalld
sudo systemctl disable firewalld

sudo systemctl enable tmp.mount
sudo yum install -y \
    epel-release \
    centos-release-kmods
sudo yum upgrade -y
sudo yum groupinstall -y GNOME
sudo yum install -y \
    bzip2 \
    tar \
    firefox \
    cloud-utils-growpart \
    open-vm-tools-desktop \
    vim \
    wget \
    htop \
    telnet \
    gcc \
    make \
    perl \
    kernel-devel \
    kernel-headers \
    autoconf \
    virtualbox-guest-additions \
    unzip \
    socat \
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

sudo systemctl enable vboxservice
sudo systemctl set-default graphical
