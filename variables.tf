variable "location" {
  type = map(string)

  default = {
    us = "Central US"
    eu = "West Europe"
  }
}