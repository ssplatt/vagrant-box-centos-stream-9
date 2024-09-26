#!/usr/bin/env bash
set -e

USE_VAGRANT=${USE_VAGRANT:-"false"}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )/"
PROJECT_ROOT="$(dirname "$DIR")"

vagrant plugin install vagrant-vmware-desktop

if [[ "$USE_VAGRANT" == "true" ]]; then
    packer init ./vagrant-vmware.pkr.hcl
    packer validate ./vagrant-vmware.pkr.hcl
    packer build \
        -color=false \
        -on-error=abort \
        ./vagrant-vmware.pkr.hcl
else
    vagrant box add bento/centos-stream-9 --no-tty --provider vmware_desktop
    vmx_file=$(find /home/runner/.vagrant.d/boxes/ -type f -name "*.vmx")
    sudo touch /etc/vmware/license-ws-foo
    packer init -var "vmx_path=$vmx_file" ./vmware.pkr.hcl
    packer validate -var "vmx_path=$vmx_file" ./vmware.pkr.hcl
    packer build \
        -color=false \
        -on-error=abort \
        -var "vmx_path=$vmx_file" \
        ./vmware.pkr.hcl

    cd ./vmware_desktop
    ls -lah

    rm -rf ./*.lck
    rm -rf ./*.scoreboard
    rm -rf ./*.log
    rm -rf ./*.box
    vmware-vdiskmanager -d ./*.vmdk
    vmware-vdiskmanager -k ./*.vmdk

    bash "$PROJECT_ROOT"/scripts/add_metadata.sh

    tar cvzf ../centos9stream.box ./*
fi
