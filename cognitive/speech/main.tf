resource "azurerm_cognitive_account" "cognitive_speech" {
  name                = "${var.name}-speech"
  resource_group_name = var.resource_group_name
  location            = var.location
  kind                = "SpeechServices"

  sku_name = "S0"

}