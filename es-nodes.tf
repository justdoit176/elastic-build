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
  instances = 3
  source = "./ubuntu_node"
  instance_name = "es_node"
  memory = 3072
  vCPUs = 3
  vol_size = 10737418240 #10G
  
  base_vol_id = module.baseres.baseimg_id
  cloudinit_id = module.baseres.cloudinit_id
#  base_img_url = "/var/lib/libvirt/images/BASE/bionic-server-cloudimg-amd64.img"
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
