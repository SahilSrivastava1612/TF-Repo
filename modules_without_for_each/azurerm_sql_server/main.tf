resource "azurerm_mssql_server" "sql_serverBlock" {
  name                         = var.sqlservername
  resource_group_name          = var.rgname
  location                     = var.location
  version                      = "12.0"
  administrator_login          = data.azurerm_key_vault_secret.vm_admin_username.value
  administrator_login_password = data.azurerm_key_vault_secret.vm_admin_password.value

}