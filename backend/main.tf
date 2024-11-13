terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "isno-rg-backend"           # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `init` command.
    storage_account_name = "isnosaqu46gc06qe"          # Can be passed via `-backend-config=`"storage_account_name=<storage account name>"` in the `init` command.
    container_name       = "tfstate"                   # Can be passed via `-backend-config=`"container_name=<container name>"` in the `init` command.
    key                  = "backend.terraform.tfstate" # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` command.
  }
}


# Configure the Microsoft Azure Provider
provider "azurerm" {
  resource_provider_registrations = "none" # This is only required when the User, Service Principal, or Identity running Terraform lacks the permissions to register Azure Resource Providers.
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
  subscription_id = "30ee9279-e76e-409d-8973-00c9792f6bcb" # Is now mandatory version 4.0
}

resource "azurerm_resource_group" "rg_backend" {
  name     = var.rg_backend_name
  location = var.rg_backend_location
}


resource "random_string" "random_string" {
  length  = 10
  special = "false"
  upper   = "false"
}

resource "azurerm_storage_account" "sa_backend" {
  name                     = "${lower(var.sa_backend_base_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg_backend.name
  location                 = azurerm_resource_group.rg_backend.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "backend"
  }
}


resource "azurerm_storage_container" "sc_backend" {
  name                  = var.sc_backend_name
  storage_account_id    = azurerm_storage_account.sa_backend.id
  container_access_type = "private"
}

data "azurerm_client_config" "current" {}



resource "azurerm_key_vault" "kv_backend" {
  name                        = var.kv_backend_name
  location                    = azurerm_resource_group.rg_backend.location
  resource_group_name         = azurerm_resource_group.rg_backend.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "Create", "List", "Delete",
    ]

    secret_permissions = [
      "Get", "Set", "List", "Delete",
    ]

    storage_permissions = [
      "Get", "Set", "List", "Delete",
    ]
  }
}

resource "azurerm_key_vault_secret" "sa_backend_key" {
  name         = var.sa_backend_key_name
  value        = azurerm_storage_account.sa_backend.primary_access_key
  key_vault_id = azurerm_key_vault.kv_backend.id
}

##