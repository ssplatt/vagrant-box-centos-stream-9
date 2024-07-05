packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

source "vagrant" "box" {
  source_path       = "ssplatt/centos-stream-9"
  output_dir        = "./vmware/"
  communicator      = "ssh"
  provider          = "vmware"
  template          = "Vagrantfile.template"
}

build {
  sources = ["source.vagrant.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
