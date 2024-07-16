packer {
  required_plugins {
    vmware = {
      version = "~> 1"
      source = "github.com/hashicorp/vmware"
    }
  }
}

variable "vbox_version" { default = "20240716.40.1" }

source "vmware-vmx" "box" {
  source_path       = "~/.vagrant.d/boxes/ssplatt-VAGRANTSLASH-centos-stream-9/${var.vbox_version}/amd64/vmware_desktop/centos9stream.vmx"
  output_directory  = "./vmware_desktop/"
  communicator      = "ssh"
  ssh_username      = "vagrant"
  ssh_password      = "vagrant"
  ssh_timeout       = "10m"
  shutdown_command  = "sudo shutdown -h now"
  format            = "vmx"
  headless          = "true"
}

build {
  sources = ["source.vmware-vmx.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
