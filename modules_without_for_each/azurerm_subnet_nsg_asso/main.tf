resource "azurerm_subnet_network_security_group_association" "subnetnsgassoc1" {
  subnet_id                 = data.azurerm_subnet.subnetidblock.id
  network_security_group_id = data.azurerm_network_security_group.nsgidblock.id
}