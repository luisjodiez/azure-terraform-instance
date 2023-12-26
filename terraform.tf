terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
  backend "azurerm" {
      resource_group_name  = "tfstates"
      storage_account_name = "ljdbstorage"
      container_name       = "tfstates"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}