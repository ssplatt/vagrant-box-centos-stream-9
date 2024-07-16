packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "box" {
  source_path       = "bento/centos-stream-9"
  output_dir        = "./vmware_desktop/"
  communicator      = "ssh"
  provider          = "vmware_desktop"
  template          = "Vagrantfile.template"
}

build {
  sources = ["source.vagrant.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
