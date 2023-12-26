terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~>3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~>1.5"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
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