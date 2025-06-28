
resource "azurerm_network_interface" "nicBlock" {
  name                = var.nicname
  location            = var.niclocation
  resource_group_name = var.nicrg

  ip_configuration {
    name                          = "internal"
    subnet_id                     =  data.azurerm_subnet.datasubnet1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = data.azurerm_public_ip.publicip1.id
  }
}

resource "azurerm_linux_virtual_machine" "linuxVMBlock1" {
  name                = var.vm_name
  resource_group_name = var.vm_rgname
  location            = var.vm_location
  size                = var.vm_size

  disable_password_authentication = "false"
  admin_username      = data.azurerm_key_vault_secret.vm_admin_username.value
  admin_password = data.azurerm_key_vault_secret.vm_admin_password.value
  
  network_interface_ids = [
    azurerm_network_interface.nicBlock.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {   
    publisher = var.publisher  #publisher ID from Azure Marketplace
    offer     = var.offer  # offer ID from Azure Marketplace
    sku       = var.sku   # SKU or plan ID from Azure Marketplace
    version   = "latest"  # version of the image, e.g., "latest"  
  }
}
