data "azurerm_storage_account" "storagedatablock"{
  name                = var.storagename
  resource_group_name = var.rgname
}

resource "azurerm_storage_container" "storagecontainer" {
  name                  = var.container_name
  storage_account_id    = data.azurerm_storage_account.storagedatablock.id
  container_access_type = var.container_access_type

}