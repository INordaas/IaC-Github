provider "azurerm" {
  features {}
}


resource "azurerm_mssql_server" "sqlserver" {
  name                         = var.sqlserver_name
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = var.sqlserver_version
  administrator_login          = var.administrator_login
  administrator_login_password = var.administrator_login_password
}

resource "azurerm_mssql_database" "db" {
  name         = var.db_name
  server_id    = azurerm_mssql_server.sqlserver.id
  max_size_gb  = 2
  sku_name     = "S0"

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }
}