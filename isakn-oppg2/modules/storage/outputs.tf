output "rgname" {
    value = azurerm_resource_group.rg.name
    description = "outputs rg name to root module"
}

output "rglocation" {
    value = azurerm_resource_group.rg.location
    description = "outputs rg name to root module"
}