provider "azurerm" {
  features {}
}

resource "azurerm_service_plan" "serviceplan" {
  name                = var.serviceplan_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  os_type             = var.os_type
  sku_name            = var.sku_name
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.webapp_name
  resource_group_name = var.rg_name
  location            = var.rg_location
  service_plan_id     = azurerm_service_plan.serviceplan.id

  site_config {}
}