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
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_service_plan.example.location
  service_plan_id     = azurerm_service_plan.example.id

  site_config {}
}