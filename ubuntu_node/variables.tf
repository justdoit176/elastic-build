#base_img_url = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
#base_img_url = "/var/lib/libvirt/images/BASE/ubuntu-18.04-minimal-cloudimg-amd64.qcow2"

variable "qemu_uri" {
  description = "QEMU connection string"
  default = "qemu:///system"
  type = string
}

variable "instances" {
  default = 1
  type = number
  description = "Number of VMs to create"
}

variable "base_img_url" {
  description = "Location of ubuntu base image to use for volumes"
  default = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
  type = string
}

variable "vol_size" {
  description = "Size of volume in bytes"
  default = 5368709120 #5G
  type = number
}

variable "memory_size" {
  description = "RAM size in MiB"
  default = 2048
  type = number
}

variable "pool_name" {
  description = "Name of pool for volume and base image"
  default = "default"
  type = string
}

variable "cpu_qty" {
  description = "Number of vCPU to assign"
  default = 2
  type = number
}

variable "instance_name" {
  description = "Name of instance"
  type = string
}

#variable "pool_name" {
#  description = "Name of pool for volume and base image"
#  default = "default"
#  type = string
#}
