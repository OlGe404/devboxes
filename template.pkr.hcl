packer {
  required_plugins {
    vagrant = {
      version = "v1.1.2"
      source  = "github.com/hashicorp/vagrant"
    }
    ansible = {
      version = "v1.1.1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

locals {
  packer_build_dir = ".build/output/${var.packer_build_name}-${var.box_release_version}-${var.box_architecture}"
}

variable "packer_build_name" {
  type        = string
  default     = ""
  description = "Name of the packer build."
  validation {
    condition     = length(var.packer_build_name) > 0
    error_message = "Var 'build_name' has to be set."
  }
}

variable "ansible_playbook_file" {
  type        = string
  default     = ""
  description = "Path to the ansible playbook used to configure the box."
  validation {
    condition     = length(var.ansible_playbook_file) > 0
    error_message = "Var 'ansible_playbook_file' has to be set."
  }
}

variable "box_source_path" {
  type        = string
  default     = ""
  description = "URL of the base box to use, e.g. 'bento/ubuntu-22.04'."
  validation {
    condition     = length(var.box_source_path) > 0
    error_message = "Var 'box_source_path' has to be set."
  }
}

variable "box_architecture" {
  type        = string
  default     = "amd64"
  description = "Architecture of the box to build."
}

variable "box_output_vagrantfile" {
  type        = string
  default     = ".build/Vagrantfile"
  description = "Vagrantfile to include in the box."
}

variable "box_source_version" {
  type        = string
  default     = ""
  description = "Version of 'box_source_path' to use."
  validation {
    condition     = length(var.box_source_version) > 0
    error_message = "Var 'box_source_version' has to be set."
  }
}

variable "box_release_version" {
  type        = string
  default     = ""
  description = "Version of the custom box to release."
  validation {
    condition     = length(var.box_release_version) > 0
    error_message = "Var 'box_release_version' has to be set in the form of 'MAJOR.MINOR.PATCH'."
  }
}

variable "vagrant_cloud_token" {
  type        = string
  default     = env("VAGRANT_CLOUD_TOKEN")
  description = "Token to authenticate against vagrant cloud API."
  validation {
    condition     = length(var.vagrant_cloud_token) > 0
    error_message = "ENV 'VAGRANT_CLOUD_TOKEN' has to be set."
  }
}

source "vagrant" "box" {
  communicator       = "ssh"
  provider           = "virtualbox"
  box_version        = var.box_source_version
  source_path        = var.box_source_path
  output_dir         = local.packer_build_dir
  output_vagrantfile = var.box_output_vagrantfile
}

build {
  name    = var.packer_build_name
  sources = ["source.vagrant.box"]
  provisioner "ansible" {
    playbook_file = var.ansible_playbook_file
  }

  post-processor "shell-local" {
    command = <<EOF
vagrant cloud publish --force --no-private --release \
--architecture ${var.box_architecture} --default-architecture \
--version-description 'Custom box based on ${var.box_source_path} v${var.box_source_version}, configured with https://github.com/OlGe404/devboxes/blob/master/${var.ansible_playbook_file}' \
OlGe404/${var.packer_build_name} ${var.box_release_version} virtualbox ${local.packer_build_dir}/package.box
EOF
  }

  post-processor "shell-local" {
    command = "rm -rf ${local.packer_build_dir}"
  }
}
