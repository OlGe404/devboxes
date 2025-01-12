source "vagrant" "box" {
  communicator = "ssh"
  source_path  = var.vagrant_source_path
  provider     = "virtualbox"
  template     = ".build/Vagrantfile"
  skip_add     = var.vagrant_skip_add
  output_dir   = local.build_output_dir
}

build {
  name    = var.packer_build_name
  sources = ["source.vagrant.box"]

  provisioner "ansible" {
    playbook_file = var.ansible_playbook_file
    host_alias    = var.packer_build_name
    groups        = var.ansible_groups
    # Necessary to correctly resolve ansible group_vars and host_vars.
    # path.root = dir where "template.pkr.hcl" lives.
    inventory_directory = path.root
    galaxy_file         = "${path.root}/requirements.yaml"
  }

  post-processors {
    post-processor "vagrant-cloud" {
      box_tag      = "devspaces/${var.packer_build_name}"
      version      = var.packer_build_version
      access_token = var.vagrant_cloud_token
    }

    # Cleanup build artifacts
    post-processor "shell-local" {
      inline = [
        "rm -rf ${local.build_output_dir}"
      ]
    }
  }
}
