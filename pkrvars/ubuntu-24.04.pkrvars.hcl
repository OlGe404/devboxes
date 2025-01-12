packer_build_name     = "ubuntu-24.04"
packer_build_version  = "0.1.0"

vagrant_source_path   = "bento/ubuntu-24.04"

ansible_playbook_file = "playbooks/ubuntu-24.04.yml"
ansible_groups        = ["ubuntu"]
