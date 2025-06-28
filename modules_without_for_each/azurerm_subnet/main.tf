resource "azurerm_network_security_group" "nsgblock1"{
  name = var.nsgname
  location = var.nsglocation
  resource_group_name = var.nsgrg

  security_rule {
    name                       = "AllowSSHandHTTP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22","80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "AllowHTTP"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["80"]
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}
resource "azurerm_subnet" "subnet1" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.address_prefixes
}

