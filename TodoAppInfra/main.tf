module "resource_group" {
  source      = "../modules_without_for_each/azurerm_resource_group"
  rg_name     = "rg-todoapp-0001"
  rg_location = "Southeast Asia"
}

# This is a test
# This ia 2nd test
# This is a 3rd Test


module "virtual_network" {
  depends_on    = [module.resource_group]
  source        = "../modules_without_for_each/azurerm_virtual_network"
  vnet_name     = "vnet-todoapp-0001"
  vnet_location = "Southeast Asia"
  rg_name       = "rg-todoapp-0001"
  address_space = ["10.10.0.0/24"]
}

module "frontend_subnet" {
  depends_on       = [module.virtual_network]
  source           = "../modules_without_for_each/azurerm_subnet"
  vnet_name        = "vnet-todoapp-0001"
  subnet_name      = "subnet-frontend-0001"
  rg_name          = "rg-todoapp-0001"
  address_prefixes = ["10.10.0.0/25"]
  nsgname          = "nsg-todoapp-0001"
  nsglocation      = "Southeast Asia"
  nsgrg            = "rg-todoapp-0001"
}

module "backend_subnet" {
  depends_on       = [module.virtual_network]
  source           = "../modules_without_for_each/azurerm_subnet"
  vnet_name        = "vnet-todoapp-0001"
  subnet_name      = "subnet-backend-0001"
  rg_name          = "rg-todoapp-0001"
  address_prefixes = ["10.10.0.128/25"]
  nsgname          = "nsg-todoapp-0001"
  nsglocation      = "Southeast Asia"
  nsgrg            = "rg-todoapp-0001"

}

module "frontend_subnet_nsg_association" {
  depends_on  = [module.frontend_subnet]
  source      = "../modules_without_for_each/azurerm_subnet_nsg_asso"
  vnet_name   = "vnet-todoapp-0001"
  subnet_name = "subnet-frontend-0001"
  rgname      = "rg-todoapp-0001"
  nsgname     = "nsg-todoapp-0001"
  nsgrg       = "rg-todoapp-0001"
}

module "backend_subnet_nsg_association" {
  depends_on  = [module.backend_subnet]
  source      = "../modules_without_for_each/azurerm_subnet_nsg_asso"
  vnet_name   = "vnet-todoapp-0001"
  subnet_name = "subnet-backend-0001"
  rgname      = "rg-todoapp-0001"
  nsgname     = "nsg-todoapp-0001"
  nsgrg       = "rg-todoapp-0001"
}

module "frontend_public_ip1" {
  depends_on              = [module.resource_group]
  source                  = "../modules_without_for_each/azurerm_public_ip"
  pip_name                = "pip-frontendtodoapp-0001"
  pip_resource_group_name = "rg-todoapp-0001"
  pip_location            = "Southeast Asia"
  pip_allocation_method   = "Static"
}

module "backend_public_ip1" {
  depends_on              = [module.resource_group]
  source                  = "../modules_without_for_each/azurerm_public_ip"
  pip_name                = "pip-backendtodoapp-0001"
  pip_resource_group_name = "rg-todoapp-0001"
  pip_location            = "Southeast Asia"
  pip_allocation_method   = "Static"
}

module "keyvault" {
  depends_on    = [module.resource_group]
  source        = "../modules_without_for_each/azurerm_keyvault"
  keyvault_name = "kv-todoapp-0001"
  location      = "Southeast Asia"
  keyrgname     = "rg-todoapp-0001"
  sku_name      = "standard"
}

module "storageaccount" {
  depends_on  = [module.resource_group]
  source      = "../modules_without_for_each/azurerm_storageaccount"
  storagename = "sttodoapp0001"
  rgname      = "rg-todoapp-0001"
  at          = "Standard"
  location    = "Southeast Asia"
  art         = "LRS"
}

module "storagecontainer" {
  depends_on            = [module.storageaccount]
  source                = "../modules_without_for_each/azurerm_storagecontainer"
  storagename           = "sttodoapp0001"
  rgname                = "rg-todoapp-0001"
  container_name        = "container-todoapp-0001"
  container_access_type = "private"
}

module "frontend_vm" {
  depends_on        = [module.frontend_subnet, module.keyvault, module.frontend_public_ip1]
  source            = "../modules_without_for_each/azurerm_virtualmachine"
  vm_name           = "vm-frontend-0001"
  vm_location       = "Southeast Asia"
  vm_rgname         = "rg-todoapp-0001"
  vm_size           = "Standard_D2s_v3"
  vm_admin_username = "AzureAdmin"
  nicname           = "nic-frontend-0001"
  niclocation       = "Southeast Asia"
  nicrg             = "rg-todoapp-0001"
  publisher         = "Canonical"
  offer             = "0001-com-ubuntu-server-jammy"
  sku               = "22_04-lts"
  vnet_name         = "vnet-todoapp-0001"
  pip_name          = "pip-frontendtodoapp-0001"
  subnet_name       = "subnet-frontend-0001"
  keyvault_name     = "kv-todoapp-0001"
  kvsecretname      = "vm-password"
  kvsecretname2     = "vm-username"
}

module "backend_vm" {
  depends_on        = [module.backend_subnet, module.keyvault, module.backend_public_ip1]
  source            = "../modules_without_for_each/azurerm_virtualmachine"
  vm_name           = "vm-backend-0001"
  vm_location       = "Southeast Asia"
  vm_rgname         = "rg-todoapp-0001"
  vm_size           = "Standard_B1s"
  vm_admin_username = "AzureAdmin"
  nicname           = "nic-backend-0001"
  niclocation       = "Southeast Asia"
  nicrg             = "rg-todoapp-0001"
  publisher         = "Canonical"
  offer             = "0001-com-ubuntu-server-focal"
  sku               = "20_04-lts"
  vnet_name         = "vnet-todoapp-0001"
  subnet_name       = "subnet-backend-0001"
  pip_name          = "pip-backendtodoapp-0001"
  keyvault_name     = "kv-todoapp-0001"
  kvsecretname      = "vm-password"
  kvsecretname2     = "vm-username"
}

module "sql_server" {
  depends_on    = [module.resource_group, module.keyvault]
  source        = "../modules_without_for_each/azurerm_sql_server"
  sqlservername = "sqlserver-todoapp-0001"
  rgname        = "rg-todoapp-0001"
  location      = "Southeast Asia"
  loginusername = "AzureAdmin"
  keyvault_name = "kv-todoapp-0001"
  kvsecretname  = "vm-password"
  kvsecretname2 = "vm-username"
}

module "sql_database" {
  depends_on    = [module.sql_server, module.resource_group]
  source        = "../modules_without_for_each/azurerm_sql_database"
  database_name = "db-todoapp-0001"
  sku_name      = "S0"
  sqlservername = "sqlserver-todoapp-0001"
  rgname        = "rg-todoapp-0001"
}


