terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.9.0"
    }
  }
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = ["${var.address_space}"]
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["${var.subnet_prefix}"]
}

resource "azurerm_public_ip" "public_ip" {
  name                = var.public_ip_name
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "loadbalancer" {
  name                = var.lb_name
  location            = var.rg_location
  resource_group_name = var.nsg_name

  frontend_ip_configuration {
    name                 = var.frontend_ip_name
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}