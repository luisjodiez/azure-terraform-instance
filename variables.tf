variable "prefix" {
  type = string
  default = "linux-vm"
}

variable "az_vm_publisher" {
  type = string
  default = "Canonical"
}

variable "az_vm_offer" {
  type = string
  default = "0001-com-ubuntu-server-jammy"
}

variable "az_vm_sku" {
  type = string
  default = "22_04-lts"
}

variable "az_vm_version" {
  type = string
  default = "latest"
}