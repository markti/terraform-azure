

module "api_hosting_plan" {
  
  source                = "../../api/host/serverless"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-plan"
  resource_group_name   = var.resource_group_name
  location              = var.location

}

locals {
    app_settings = {
        "CosmosDb-ConnectionString" = "foo"
    }
}


module "api_fn_foo" {
  
  source                        = "../../api/fn/fn_http"
  
  app_name                      = var.app_name
  env_name                      = var.env_name

  name                          = "${var.app_name}-${var.env_name}-foo"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_service_plan_id           = module.api_hosting_plan.id
  storage_connection_string     = module.api_hosting_plan.storage_connection_string
  azure_function_version        = "~2"
  worker_runtime                = "dotnet"
  app_settings                  = local.app_settings

}
