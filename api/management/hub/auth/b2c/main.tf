

resource "azurerm_api_management_authorization_server" "apim_auth" {

  name                         = var.name
  api_management_name          = var.apim_name
  resource_group_name          = var.resource_group_name
  display_name                 = var.name
  authorization_endpoint       = "https://${var.tenant_name}.b2clogin.com/${var.tenant_name}.onmicrosoft.com/oauth2/v2.0/authorize?p=${var.signin_policy}"
  client_id                    = var.client_id
  client_secret                = var.client_secret
  client_registration_endpoint = "https://${var.tenant_name}.b2clogin.com/${var.tenant_name}.onmicrosoft.com/oauth2/v2.0/authorize?p=${var.signin_policy}"
  token_endpoint               = "https://${var.tenant_name}.b2clogin.com/${var.tenant_name}.onmicrosoft.com/oauth2/v2.0/token?p=${var.signin_policy}"

  default_scope                = var.default_scope

  client_authentication_method = [
    "Body"
  ]

  authorization_methods = [
    "GET"
  ]

  bearer_token_sending_methods = [
    "authorizationHeader"
  ]

  grant_types = [
    "authorizationCode",
    "implicit",
  ]
}
