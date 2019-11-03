module "baseres" {
  source = "./shared-resources"
  ssh_pub_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfQTG/Xymf1Yc2AXxdcGzjsA1urkGpaQGo9Bmcw/E6teUMxLXYYXSt+gPN+5BvMPInu6x3+haw6k5UZtfjlwJp9iMBBhzpwiN1aKp05+sheZoYnzu2I4wSND5yKn8RaSo0Gse3Yts8cBAf9P1pE8CBrEndIRKKQbhX+xo89EUTiIxqkIegyM3tAjkhb9g4qXdf+fBxziMkjb2SrlRgUR/49A4lSmKOjBlflWq6BA3NMLWZtye0GMJWaLbnskb1qG4t1tk1eSXSC3kZf1TuBZHZxJoQ0qp3e73/Euvo0BsyK+YEFtqv+xDwtAQTb5OmbFiegaYPrHIU0rMSuL5N7g+R"
}

module "ubuntu_nodes" {
  instances = 2
  source = "./ubuntu_node"
  instance_name = "es_node"
  base_vol_id = module.baseres.baseimg_id
  cloudinit_id = module.baseres.cloudinit_id
#  base_img_url = "/var/lib/libvirt/images/BASE/bionic-server-cloudimg-amd64.img"
}

terraform {
  required_version = ">= 0.12"
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
