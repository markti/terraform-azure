
module "microservice_drug" {
  
  source                          = "../../microservices/baseline"

  app_name                        = var.app_name
  env_name                        = var.env_name
  
  name                            = "${var.app_name}-${var.env_name}-drug"
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
  api_path                        = "drug"
  apim_ip_address                 = module.microservice_hub.apim_public_ip_address
  
}


module "svc_drug_crud" {
  
  source                = "../../api/management/ops/crud"

  resource_group_name   = var.resource_group_name
  apim_name             = module.microservice_hub.apim_name
  api_name              = module.microservice_drug.api_name
  backend_name          = var.terraform_application_id
  op_prefix             = "pcna-drug"
  entity_type           = "Drug"
  url_template          = "/drug"
  parameter_1           = "drug_id"

}

  /*
  get_parameters        = {
                            name = "drug_id"
                            required = true
                            type = "string"
                          }*/

/*
module "svc_drug_get" {
  
  source                = "../../api/management/ops/parameters_1"

  resource_group_name   = var.resource_group_name
  apim_name             = module.microservice_hub.apim_name
  api_name              = module.microservice_drug.api_name
  backend_name          = var.terraform_application_id

  operation_id          = "pcna-drug-get"
  display_name          = "GET Drug"
  description           = "Get a Drug by its unqiue identifier"
  method                = "GET"
  url_template          = "drug/{drug_id}"
  parameter_1           = "drug_id"
}
*/