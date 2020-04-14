
resource "azurerm_application_insights" "main" {

  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = "web"

  tags = {
    app = var.app_name
    env = var.env_name
  }
}
