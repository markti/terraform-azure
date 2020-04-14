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


resource "azurerm_managed_disk" "disk_os" {
  name                  = "${var.name}-disk-os"
  location              = var.location
  resource_group_name   = var.resource_group_name
  storage_account_type  = "Standard_LRS"
  create_option         = "FromImage"
  disk_size_gb          = "30"
  image_reference_id    = data.azurerm_platform_image.linux_image.id
  os_type               = "Linux"

  tags = {
    app = var.app_name
    env = var.env_name
  }
}


resource "azurerm_virtual_machine" "vm" {
  name                  = var.name
  location              = var.location
  resource_group_name   = var.resource_group_name
  network_interface_ids = [module.primary_nic.nic_id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_os_disk {
    name              = "${var.name}-disk-os"
    caching           = "ReadWrite"
    managed_disk_type = azurerm_managed_disk.disk_os.storage_account_type
    create_option     = "Attach"
    managed_disk_id   = azurerm_managed_disk.disk_os.id
    os_type           = azurerm_managed_disk.disk_os.os_type
  }

  os_profile {
    computer_name  = var.name
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
