resource "azurerm_resource_group" "RGBlock" {
  name = var.rg_name
  location = var.rg_location
}