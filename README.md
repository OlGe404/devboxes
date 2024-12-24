# devboxes

Sources:

* [Vagrant providers: Basic usage](https://developer.hashicorp.com/vagrant/docs/providers/basic_usage)
* [Creating a Base Box](https://developer.hashicorp.com/vagrant/docs/boxes/base)
* [Creating a Base Box (for VirtualBox)](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes#virtualbox-guest-additions)

# Base box checklist

* [Install packer and vagrant](https://developer.hashicorp.com/vagrant/docs/installation)
* ["vagrant" User](https://developer.hashicorp.com/vagrant/docs/boxes/base#vagrant-user)
* [Root Password: "vagrant"](https://developer.hashicorp.com/vagrant/docs/boxes/base#root-password-vagrant)
* [Password-less Sudo](https://developer.hashicorp.com/vagrant/docs/boxes/base#password-less-sudo)
* [SSH Tweaks](https://developer.hashicorp.com/vagrant/docs/boxes/base#ssh-tweaks)

## VirtualBox checklist

* [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [VirtualBox Configurations](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/configuration)
* [VirtualBox Guest Additions](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes#virtualbox-guest-additions)
* [Use vagrant package --base <name> for packaging](https://developer.hashicorp.com/vagrant/docs/providers/virtualbox/boxes#packaging-the-box)

# Cheatsheet

```bash
vagrant global-status --prune
vagrant box list
vagrant up --provision
vagrant destroy
vagrant halt
vagrant suspend
```
