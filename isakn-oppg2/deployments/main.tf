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

module "storage" {
  source           = "../modules/storage"
  rg_name          = "${terraform.workspace}-${var.rg_name}"
  replication_type = var.replication_type
  rg_location      = var.rg_location
  sa_base_name     = "${terraform.workspace}${var.sa_base_name}"
  account_tier     = var.account_tier
  sc_name = "${terraform.workspace}-${var.sc_name}"
  sc_access_type = var.sc_access_type
  blob_name = "${terraform.workspace}-${var.blob_name}"
  blob_type = var.blob_type
}

module "networking" {
  source = "../modules/networking"
}