#!/usr/bin/env bash
# set -e

packer init ./vagrant-vmware.pkr.hcl
packer validate ./vagrant-vmware.pkr.hcl
vagrant plugin install vagrant-vmware-desktop
packer build \
    -color=false \
    ./vagrant-vmware.pkr.hcl
    # -on-error=abort \

find . -name "*.log" -exec cat {} \;