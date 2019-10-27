module "ubuntu_node_1" {
  source = "./ubuntu_node"
  instance_name = "my_es_1"
  base_img_url = "/var/lib/libvirt/images/BASE/bionic-server-cloudimg-amd64.img"
}

#module "ubuntu_node_2" {
#  source = "./ubuntu_node"
#  instance_name = "my_es_2"
#  base_img_url = "/var/lib/libvirt/images/BASE/bionic-server-cloudimg-amd64.img"
#}

terraform {
  required_version = ">= 0.12"
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
