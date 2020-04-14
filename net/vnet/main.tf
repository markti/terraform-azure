resource "azurerm_virtual_network" "vnet" {

  name                = "${var.name}-network"
  address_space       = ["${var.vnet_range}"]
  location            = var.location
  resource_group_name = var.resource_group_name

}

resource "azurerm_subnet" "subnet1" {
  
  name                 = "subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.subnet1_range

}