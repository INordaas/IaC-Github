terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "isno-rg-backend"               # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "isnosaq7gzl035nr"              # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
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

resource "random_string" "random" {
  length  = 8
  special = false
  upper = false
}



module "storage" {
  source           = "../modules/storage"
  rg_name          = "${var.rg_name}-${local.env}-${random_string.random.result}"
  replication_type = var.replication_type
  rg_location      = var.rg_location
  sa_base_name     = "${var.sa_base_name}${local.env}${random_string.random.result}"
  account_tier     = var.account_tier
  sc_name          = "${var.sc_name}-${local.env}-${random_string.random.result}"
  sc_access_type   = var.sc_access_type
  blob_name        = "${var.blob_name}-${local.env}-${random_string.random.result}"
  blob_type        = var.blob_type
}

module "networking" {
  source        = "../modules/networking"
  rg_name       = module.storage.rgname
  rg_location   = module.storage.rglocation
  nsg_name      = "${var.nsg_name}-${local.env}-${random_string.random.result}"
  vnet_name     = "${var.vnet_name}-${local.env}-${random_string.random.result}"
  address_space = var.address_space
  subnet_name   = "${var.subnet_name}-${local.env}-${random_string.random.result}"
  subnet_prefix = var.subnet_prefix
}

module "database" {
  source = "../modules/database"
  rg_name       = module.storage.rgname
  rg_location   = module.storage.rglocation
  sqlserver_name = "${var.sqlserver_name}-${local.env}-${random_string.random.result}"
  sqlserver_version =  var.sqlserver_version
  administrator_login_password = var.administrator_login_password
  db_name = "${var.db_name}-${local.env}-${random_string.random.result}"
}