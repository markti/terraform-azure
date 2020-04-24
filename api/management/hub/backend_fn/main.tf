
resource "azurerm_api_management_backend" "apim_backend" {
  
  name                = var.name
  resource_group_name = var.resource_group_name
  api_management_name = var.apim_name
  protocol            = var.protocol
  url                 = "https://${var.function_name}.azurewebsites.net/api"

  credentials {
    header = {
      "x-functions-key" = "\{\{${var.function_key_named_value}\}\}",
    }
  }

}