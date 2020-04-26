


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
  
  source                        = "../../api/fn/fn_http"
  
  app_name                      = var.app_name
  env_name                      = var.env_name

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_service_plan_id           = var.hosting_plan_id
  storage_connection_string     = var.hosting_storage_connection_string
  azure_function_version        = var.azure_function_version
  worker_runtime                = var.worker_runtime
  app_settings                  = local.combined_settings

}
/*
module "api_eventgrid_topic" {
  
  source                        = "../../messaging/eventgrid/topic"
  
  app_name                      = var.app_name
  env_name                      = var.env_name

  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location

}
*/