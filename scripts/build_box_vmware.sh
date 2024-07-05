#!/usr/bin/env bash
set -e

packer init ./vagrant-vmware.pkr.hcl
packer validate ./vagrant-vmware.pkr.hcl
packer build \
    -color=false \
    -on-error=abort \
    ./vagrant-vmware.pkr.hcl
