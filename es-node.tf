# instance the provider
provider "libvirt" {
  uri = "qemu:///system"
}

variable "base_img_url" {
  type = "string"
}

resource "libvirt_pool" "elastic" {
  name = "elastic"
  type = "dir"
  path = "/var/lib/libvirt/images/elastic"
}

# We fetch the latest ubuntu release image from their mirrors
resource "libvirt_volume" "ubuntu-qcow2" {
  name   = "ubuntu-qcow2"
  pool   = libvirt_pool.elastic.name
  source = var.base_img_url
#  source = "/var/lib/libvirt/images/BASE/ubuntu-18.04-minimal-cloudimg-amd64.qcow2"
  format = "qcow2"
}

resource "libvirt_volume" "elastic-qcow2" {
  name = "elastic-qcow2"
  pool = libvirt_pool.elastic.name
  base_volume_id = libvirt_volume.ubuntu-qcow2.id
  size = 10737418240 #10G
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

# for more info about paramater check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
# Use CloudInit to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.elastic.name
}

# Create the machine
resource "libvirt_domain" "domain-es-n1" {
  name   = "es-n1"
  memory = "3072"
  vcpu   = 2

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    network_name = "default"
  }

  # IMPORTANT: this is a known bug on cloud images, since they expect a console
  # we need to pass it
  # https://bugs.launchpad.net/cloud-images/+bug/1573095
  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  disk {
    volume_id = libvirt_volume.elastic-qcow2.id
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

terraform {
  required_version = ">= 0.12"
}

# IPs: use wait_for_lease true or after creation use terraform refresh and terraform show for the ips of domain
