data "azurerm_key_vault" "keyvault1" {
  name                = var.keyvault_name
  resource_group_name = var.rgname
}

data "azurerm_key_vault_secret" "vm_admin_password" {
  name         = var.kvsecretname
  key_vault_id = data.azurerm_key_vault.keyvault1.id
}

data "azurerm_key_vault_secret" "vm_admin_username" {
  name = var.kvsecretname2
  key_vault_id = data.azurerm_key_vault.keyvault1.id
}