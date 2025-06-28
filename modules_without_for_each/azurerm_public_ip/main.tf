resource "azurerm_public_ip" "example" {
  name                = var.pip_name
  resource_group_name = var.pip_resource_group_name
  location            = var.pip_location
  allocation_method   = var.pip_allocation_method
 
}