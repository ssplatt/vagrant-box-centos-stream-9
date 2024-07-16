packer {
  required_plugins {
    vmware = {
      version = "~> 1"
      source = "github.com/hashicorp/vmware"
    }
  }
}

variable "vmx_path" { default = "/home/runner/.vagrant.d/boxes/ssplatt-VAGRANTSLASH-centos-stream-9/20240716.40.1/vmware_desktop/centos9stream.vmx" }

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
}

build {
  sources = ["source.vmware-vmx.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
