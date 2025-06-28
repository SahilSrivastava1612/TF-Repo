data "azurerm_client_config" "current" {}

resource "azurerm_key_vault" "keyvault1" {
  name                        = var.keyvault_name
  location                    = var.location
  resource_group_name         = var.keyrgname
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                   =  var.sku_name
}





