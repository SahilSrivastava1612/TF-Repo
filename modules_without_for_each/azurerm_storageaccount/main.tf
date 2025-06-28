resource "azurerm_storage_account" "storageblock" {
  name                     = var.storagename
  resource_group_name      = var.rgname
  location                 = var.location
  account_tier             = var.at
  account_replication_type = var.art

}