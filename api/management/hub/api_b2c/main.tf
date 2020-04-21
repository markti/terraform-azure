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
      <openid-config url="https://${var.b2c_settings.tenant_name}.b2clogin.com/${var.b2c_settings.tenant_name}.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=${var.b2c_settings.policy_name}" />
      <required-claims>
          <claim name="aud">
              <value>${var.b2c_settings.client_id}</value>
          </claim>
      </required-claims>
    </validate-jwt>
    <set-header name="${var.b2c_settings.header_prefix}_UID" exists-action="append">
        <value>@(context.Request.Headers["Authorization"].First().Split(' ')[1].AsJwt()?.Claims["oid"].FirstOrDefault())</value>
    </set-header>
    <set-header name="${var.b2c_settings.header_prefix}_EMAIL" exists-action="append">
        <value>@(context.Request.Headers["Authorization"].First().Split(' ')[1].AsJwt()?.Claims["emails"].FirstOrDefault())</value>
    </set-header>
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