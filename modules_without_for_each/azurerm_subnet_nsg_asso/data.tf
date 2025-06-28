data "azurerm_subnet" "subnetidblock" {
  virtual_network_name = var.vnet_name
  resource_group_name = var.rgname
  name = var.subnet_name
}

data "azurerm_network_security_group" "nsgidblock" {
  name                = var.nsgname
  resource_group_name = var.nsgrg
}