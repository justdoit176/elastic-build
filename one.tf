provider "libvirt" {
    uri = "qemu:///system"
}

resource "libvirt_domain" "es-n2" {
  name = "es-n2"
}
