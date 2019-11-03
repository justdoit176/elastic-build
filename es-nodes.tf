terraform {
  required_version = ">= 0.12"
}

variable "ssh_pub_key" {
  type = string
  description = "SSH public key to access the VMs"
}

module "baseres" {
  source = "./shared-resources"
  ssh_pub_key = var.ssh_pub_key
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

# IPs: after creation use terraform refresh and terraform show to retrieve the IPs of domain(s)
