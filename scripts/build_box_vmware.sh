#!/usr/bin/env bash
set -e

USE_VAGRANT=${USE_VAGRANT:-"false"}

vagrant plugin install vagrant-vmware-desktop

if [[ "$USE_VAGRANT" == "true" ]]; then
    packer init ./vagrant-vmware.pkr.hcl
    packer validate ./vagrant-vmware.pkr.hcl
    packer build \
        -color=false \
        -on-error=abort \
        ./vagrant-vmware.pkr.hcl
else
    vagrant box add ssplatt/centos-stream-9 --no-tty --provider vmware_desktop
    sudo apt-get install -y tree
    tree ~/.vagrant.d
    
    packer init ./vmware.pkr.hcl
    packer validate ./vmware.pkr.hcl
    packer build \
        -color=false \
        -on-error=abort \
        ./vmware.pkr.hcl

    cd ./vmware_desktop
    ls -lah

    rm -rf ./*.lck
    rm -rf ./*.scoreboard
    rm -rf ./*.log
    rm -rf ./*.box
    vmware-vdiskmanager -d ./packer-box-*.vmdk
    vmware-vdiskmanager -k ./packer-box-*.vmdk

    tar cvzf ../centos9stream.box ./*
fi
