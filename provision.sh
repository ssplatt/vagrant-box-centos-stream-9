#!/usr/bin/env bash
set -e

echo ":::: Running as user $(whoami) ... "
id
echo ":::: Home dir: $HOME ..."

## Disable selinux
sudo setenforce 0
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config

## Upgrade all packages
sudo yum upgrade -y
sudo yum groupinstall -y "Server with GUI"
sudo systemctl set-default graphical
sudo yum install -y epel-release
sudo yum install -y \
    cloud-utils-growpart \
    cloud-init \
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
