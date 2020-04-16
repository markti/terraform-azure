data "azurerm_client_config" "current" {}

resource "azurerm_api_management_api" "api" {

  resource_group_name = var.resource_group_name
  api_management_name = var.apim_name
  revision            = var.revision
  name                = var.name
  display_name        = var.description
  path                = var.path
  protocols           = [var.primary_protocol]

}

resource "azurerm_api_management_api_policy" "api_policy" {
  api_name            = azurerm_api_management_api.api.name
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name

  xml_content = <<XML
<policies>
  <inbound>
    <validate-jwt header-name="Authorization" failed-validation-httpcode="401" failed-validation-error-message="Unauthorized. Access token is missing or invalid.">
      <openid-config url="https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/.well-known/openid-configuration" />
      <required-claims>
          <claim name="aud">
              <value>${var.scope}</value>
          </claim>
      </required-claims>
    </validate-jwt>
    <set-backend-service id="tf-generated-policy" backend-id="${var.backend_name}" />
    <base />
  </inbound>    
  <backend>
    <base />
  </backend>
  <outbound>
    <base />
  </outbound>
  <on-error>
    <base />
  </on-error>
</policies>
XML
}

resource "azurerm_api_management_product_api" "product_link" {
  api_name            = azurerm_api_management_api.api.name
  product_id          = var.product_id
  api_management_name = var.apim_name
  resource_group_name = var.resource_group_name
}