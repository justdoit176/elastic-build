# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

module "ubuntu_node" {
  source = "./ubuntu_node"
  instance_name = "my_es_1"
}

terraform {
  required_version = ">= 0.12"
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
