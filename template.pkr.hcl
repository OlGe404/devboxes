packer {
  required_plugins {
    vagrant = {
      version = "~> 1"
      source  = "github.com/hashicorp/vagrant"
    }
  }
}

variable "source_path" {
  type    = string
  default = "ubuntu/jammy64"
}

variable "box_version" {
  type    = string
  default = "v20240514.0.0"
}

variable "output_dir" {
  type    = string
  default = "./outputs"
}

variable "skip_package" {
  type    = bool
  default = false
}

variable "add_force" {
  type    = bool
  default = false
}

source "vagrant" "box" {
  communicator = "ssh"
  output_dir   = var.output_dir
  source_path  = var.source_path
  box_version  = var.box_version
  skip_package = var.skip_package
  add_force    = var.add_force
  provider     = "virtualbox"
}

build {
  sources = ["source.vagrant.box"]

  # Remove build artifacts to not fail on subsequent runs
  post-processor "shell-local" {
    inline = ["rm -rf ${var.output_dir}"]
    inline_shebang = "/bin/bash -e"
  }
}
