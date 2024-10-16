packer {
  required_plugins {
    vmware = {
      version = "~> 1"
      source = "github.com/hashicorp/vmware"
    }
  }
}

variable "vmx_path" { 
  type = string
  default = "/home/runner/.vagrant.d/boxes/bento-VAGRANTSLASH-centos-stream-9/202407.23.0/vmware_desktop/centos-stream-9-amd64.vmx"
}

source "vmware-vmx" "box" {
  source_path       = "${var.vmx_path}"
  output_directory  = "./vmware_desktop/"
  communicator      = "ssh"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_timeout       = "10m"
  shutdown_command  = "sudo shutdown -h now"
  format            = "vmx"
  headless          = "true"
  vmx_data = {
    "ethernet0.networkName": "VM Network",
    "ethernet0.ipAddress": "192.168.168.50",
    "ethernet0.subnetMask": "255.255.255.0",
    "ethernet0.defaultGateway": "192.168.168.2"
  }
}

build {
  sources = ["source.vmware-vmx.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
