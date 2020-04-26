


locals {

  required_settings = {
      "APPINSIGHTS_INSTRUMENTATIONKEY"    = var.instrumentation_key,
      "WEBSITE_RUN_FROM_PACKAGE"          = local.code_drop_url,
      "ClientID"                          = module.service_principal.client_id,
      "ClientSecret"                      = module.service_principal.client_secret
  }
  combined_settings = merge(local.required_settings, var.app_settings)
}


module "api_fn" {
  
  source                        = "../../api/fn/fn_eventgrid"
  
  app_name                      = var.app_name
  env_name                      = var.env_name

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_service_plan_id           = var.hosting_plan_id
  storage_connection_string     = var.storage_connection_string
  azure_function_version        = var.azure_function_version
  worker_runtime                = var.worker_runtime
  app_settings                  = local.combined_settings

}

module "api_eventgrid_topic" {
  
  source                        = "../../messaging/eventgrid/topic"
  
  app_name                      = var.app_name
  env_name                      = var.env_name

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location

}

module "secret_topic_endpoint" {
  
  source                = "github.com/markti/terraform-azure/security/secret"

  app_name                      = var.app_name
  env_name                      = var.env_name
  keyvault_id           = var.keyvault_id
  
  name                  = "Eventgrid-${var.service_name}-Endpoint"
  value                 = module.api_eventgrid_topic.endpoint

}

module "secret_topic_accesskey" {
  
  source                = "github.com/markti/terraform-azure/security/secret"

  app_name                      = var.app_name
  env_name                      = var.env_name
  keyvault_id           = var.keyvault_id
  
  name                  = "Eventgrid-${var.service_name}-AccessKey"
  value                 = module.api_eventgrid_topic.primary_access_key

}