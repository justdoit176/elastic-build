variable "ssh_pub_key" {
  type = string
  description = "SSH public key to access the VMs"
}

variable "base_img_src" {
  type = string
  description = "Base img source location"
}

output "Instances_IP" {
  value = flatten(module.ubuntu_nodes.instances_ip)
}


