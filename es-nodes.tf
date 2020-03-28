terraform {
  required_version = ">= 0.12"
}

variable "ssh_pub_key" {
  type = string
  description = "SSH public key to access the VMs"
}

variable "base_img_src" {
  type = string
  description = "Base img source location"
}

module "baseres" {
  source = "./shared-resources"
  ssh_pub_key = var.ssh_pub_key
  base_img_src = var.base_img_src
}

module "ubuntu_nodes" {
  source = "./ubuntu_node"
  name = "elastixluster"
  instance_name = "es_node"
  memory = 3072
  vCPUs = 3
  vol_size = 10737418240 #10G
  instances = 3
  base_vol_id = module.baseres.baseimg_id
  cloudinit_id = module.baseres.cloudinit_id
}

output "Instances_IP" {
  value = module.ubuntu_nodes.instances_ip
}

# IPs: after creation use terraform refresh and terraform show to retrieve the IPs of domain(s)
