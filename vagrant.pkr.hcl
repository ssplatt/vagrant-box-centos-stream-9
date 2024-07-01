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
  output_dir        = "./output/"
  communicator      = "ssh"
  provider          = "virtualbox"
  template          = "Vagrantfile.template"
  skip_add          = "true"
}

build {
  sources = ["source.vagrant.box"]
  provisioner "shell" {
    script            = "provision.sh"
  }
}
