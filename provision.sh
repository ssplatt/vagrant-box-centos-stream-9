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

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install -y google-chrome-stable_current_x86_64.rpm
sudo rm -f google-chrome-stable_current_x86_64.rpm

if [[ ! -s /home/vagrant/.ssh/authorized_keys ]]; then
    mkdir -p /home/vagrant/.ssh
    wget https://raw.githubusercontent.com/hashicorp/vagrant/refs/heads/main/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
    chmod 700 /home/vagrant/.ssh
    chmod 600 /home/vagrant/.ssh/authorized_keys
    chown -R vagrant:vagrant /home/vagrant/.ssh
fi

sudo systemctl enable vboxservice
sudo systemctl set-default graphical

sudo dnf remove -y --oldinstallonly
