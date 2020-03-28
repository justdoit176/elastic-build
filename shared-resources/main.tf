# Libvirt provider
provider "libvirt" {
  uri = "qemu:///system"
}

output "baseimg_id" {
  value = libvirt_volume.baseimg-qcow2.id
}

output "cloudinit_id" {
  value = libvirt_cloudinit_disk.commoninit.id
}

resource "libvirt_pool" "basepool" {
  name = var.basepool_name
  type = "dir"
  path = "/var/lib/libvirt/images/${var.basepool_name}"
  xml {
    xslt = file("${path.module}/poolperms.xsl")
  }
}

# We fetch the latest release image from their mirrors
resource "libvirt_volume" "baseimg-qcow2" {
  name   = "ubuntu_cloudimg.qcow2"
  pool   = libvirt_pool.basepool.name
  source = var.base_img_src
  format = "qcow2"
}

data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
  vars = {
    ssh_pub_key = chomp(var.ssh_pub_key)
  }
}

data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}

# for more info about parameters check this out
# https://github.com/dmacvicar/terraform-provider-libvirt/blob/master/website/docs/r/cloudinit.html.markdown
# Use CloudInit to add our ssh-key to the instance
# you can add also meta_data field
resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "cloudinit.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.basepool.name
}
