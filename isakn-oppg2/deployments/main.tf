terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "isno-rg-backend"               # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "isnosaqu46gc06qe"              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "deployments.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}

provider "azurerm" {
  features {}
}

locals {
  env = terraform.workspace
}

module "storage" {
  source           = "../modules/storage"
  rg_name          = "${var.rg_name}-${local.env}"
  replication_type = var.replication_type
  rg_location      = var.rg_location
  sa_base_name     = "${var.sa_base_name}${local.env}"
  account_tier     = var.account_tier
  sc_name          = "${var.sc_name}-${local.env}"
  sc_access_type   = var.sc_access_type
  blob_name        = "${var.blob_name}-${local.env}"
  blob_type        = var.blob_type
}

module "networking" {
  source        = "../modules/networking"
  rg_name       = module.storage.rgname
  rg_location   = module.storage.rglocation
  nsg_name      = "${var.nsg_name}-${local.env}"
  vnet_name     = "${var.vnet_name}-${local.env}"
  address_space = var.address_space
  subnet_name   = "${var.subnet_name}-${local.env}"
  subnet_prefix = var.subnet_prefix
}