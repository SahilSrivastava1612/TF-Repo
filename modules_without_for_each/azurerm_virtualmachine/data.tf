data "azurerm_subnet" "datasubnet1" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.nicrg
}

data "azurerm_public_ip" "publicip1" {
  name                = var.pip_name
  resource_group_name = var.nicrg
}

data "azurerm_key_vault" "keyvault1" {
  name                = var.keyvault_name
  resource_group_name = var.nicrg
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = var.kvsecretname
  key_vault_id = data.azurerm_key_vault.keyvault1.id
}

data "azurerm_key_vault_secret" "vm_admin_username" {
  name = var.kvsecretname2
  key_vault_id = data.azurerm_key_vault.keyvault1.id
}