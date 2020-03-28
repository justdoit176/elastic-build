variable "basepool_name" {
  description = "Storage pool for base images"
  type = string
}

variable "base_img_src" {
  description = "Source of the base image"
  type = string
  default = "https://cloud-images.ubuntu.com/bionic/current/bionic-server-cloudimg-amd64.img"
}

variable "ssh_pub_key" {
  description = "SSH public key"
  type = string
}
