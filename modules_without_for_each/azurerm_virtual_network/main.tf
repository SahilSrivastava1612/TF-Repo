resource "azurerm_virtual_network" "example" {
  name                = var.vnet_name
  location            = var.vnet_location
  resource_group_name = var.rg_name
  address_space       = var.address_space
}