source "vagrant" "box" {
  communicator = "ssh"
  source_path  = var.vagrant_source_path
  provider     = "virtualbox"
  template     = ".build/Vagrantfile"
  skip_add     = var.vagrant_skip_add
  output_dir   = ".build/outputs/${var.packer_build_name}"
}

build {
  name    = var.packer_build_name
  sources = ["source.vagrant.box"]

  provisioner "ansible" {
    playbook_file = var.ansible_playbook_file
    host_alias    = var.packer_build_name
    groups        = var.ansible_groups
    # path.root = dir where "template.pkr.hcl" lives
    inventory_directory = path.root
    galaxy_file         = "${path.root}/requirements.yaml"
  }

  post-processors {
    post-processor "shell-local" {
      inline = [
        "rm -rf .build/outputs/ubuntu-24.04"
      ]
    }
  }
}
