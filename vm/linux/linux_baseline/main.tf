module "primary_nic" {
  source                = "../../../net/nic"
  resource_group_name   = var.resource_group_name
  location              = var.location
  name                  = var.name
  subnet_id             = var.subnet_id
}

data "azurerm_platform_image" "linux_image" {
  location  = var.location
  publisher = "Canonical"
  offer     = "UbuntuServer"
  sku       = "18.04-LTS"
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [module.primary_nic.nic_id]
  vm_size               = "Standard_DS1_v2"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.name}-disk-os"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled       = true
    storage_uri   = var.diag_endpoint
  }

  tags = {
    app = var.app_name
    env = var.env_name
  }
}
