variable "packer_build_name" {
  type        = string
  default     = ""
  description = "Name of the packer build."
  validation {
    condition     = length(var.packer_build_name) > 0
    error_message = "Var 'build_name' has to be set."
  }
}

variable "packer_build_version" {
  type        = string
  description = "Version to release the devbox to vagrant cloud with. Has to be semver compatible."
  validation {
    condition     = length(regex("^\\d+\\.\\d+\\.\\d+$", var.packer_build_version)) > 0
    error_message = "Var 'packer_build_version' has to be set in the form of 'X.Y.Z', e.g. '0.1.0'."
  }
}

variable "ansible_playbook_file" {
  type        = string
  default     = ""
  description = "Path to the ansible-playbook file to setup the devbox with."
  validation {
    condition     = length(var.ansible_playbook_file) > 0
    error_message = "Var 'ansible_playbook_file' has to be set."
  }
}

variable "ansible_groups" {
  type        = list(string)
  default     = []
  description = "List of groups to use when running ansible-playbook."
}

variable "vagrant_source_path" {
  type        = string
  default     = ""
  description = "URL of the vagrant box to use, e.g. 'bento/ubuntu-24.04'."
  validation {
    condition     = length(var.vagrant_source_path) > 0
    error_message = "Var 'vagrant_source_path' has to be set."
  }
}

variable "vagrant_skip_add" {
  type        = bool
  default     = env("VAGRANT_SKIP_ADD")
  description = <<EOF
    Set this 'true' to skip 'vagrant box add' before the build starts.
    This is useful if 'vagrant_source_path' is already present on your system.
  EOF
}
