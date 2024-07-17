#!/usr/bin/env bash
set -e

echo ":::: Running as user $(whoami) ... "
id
echo ":::: Home dir: $HOME ..."

sestatus=$(sudo getenforce)
echo $sestatus
if [[ "$sestatus" != "Disabled" ]]; then
    sudo setenforce 0
    sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/' /etc/selinux/config
fi

sudo yum install -y epel-release
sudo yum upgrade -y
sudo yum groupinstall -y GNOME
rpm --import 'https://github.com/rabbitmq/signing-keys/releases/download/3.0/rabbitmq-release-signing-key.asc'
rpm --import 'https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-erlang.E495BB49CC4BBE5B.key'
rpm --import 'https://github.com/rabbitmq/signing-keys/releases/download/3.0/cloudsmith.rabbitmq-server.9F4587F226208342.key'
sudo yum install -y \
    gdm \
    firefox \
    cloud-utils-growpart \
    cloud-init \
    open-vm-tools-desktop \
    vim \
    wget \
    htop \
    telnet \
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
