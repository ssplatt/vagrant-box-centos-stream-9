#!/usr/bin/env bash
set -e

packer init ./vagrant-vmware.pkr.hcl
packer validate ./vagrant-vmware.pkr.hcl
vagrant plugin install --plugin-version=3.0.1 vagrant-vmware-desktop
packer build \
    -color=false \
    -on-error=abort \
    ./vagrant-vmware.pkr.hcl
