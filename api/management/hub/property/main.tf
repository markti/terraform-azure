
resource "azurerm_api_management_property" "property" {

  name                = "${var.name}-key"
  resource_group_name = var.resource_group_name
  api_management_name = var.apim_name
  display_name        = "${var.name}-key"
  value               = var.value
  secret              = var.secret

}
