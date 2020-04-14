
module "microservice_usdl" {
  
  source                          = "../../microservices/baseline"

  app_name                        = var.app_name
  env_name                        = var.env_name
  
  name                            = "${var.app_name}-${var.env_name}-usdl"
  resource_group_name             = var.resource_group_name
  location                        = var.location
  hosting_plan_id                 = module.microservice_hub.hosting_plan_id
  storage_connection_string       = module.microservice_hub.storage_connection_string
  azure_function_version          = "~2"
  worker_runtime                  = "dotnet"
  app_settings                    = local.app_settings

  instrumentation_key             = module.microservice_hub.instrumentation_key
  keyvault_id                     = module.microservice_hub.keyvault_id

  deployment_storage_account_name = module.microservice_hub.code_storage_account_name
  deployment_storage_container    = module.microservice_hub.code_storage_container
  deployment_package_sas          = module.microservice_hub.code_storage_sas
  deployment_package_filename     = "./samples/deployments/CurrentDeployment.zip"

  apim_name                       = module.microservice_hub.apim_name
  api_path                        = "usdl"
  apim_ip_address                 = module.microservice_hub.apim_public_ip_address

}