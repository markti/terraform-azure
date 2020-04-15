
provider "azurerm" {
  version = "=2.3.0"
  features {}
}

provider "random" {
  version = "=2.2.0"
}

provider "azuread" {
  version = "=0.6.0"
}

resource "azurerm_resource_group" "primary" {
  name     = "${var.app_name}-${var.env_name}-${var.primary_suffix}"
  location = var.primary_region
}

/*
module "lab_vm_monitoring" {
  source                = "./labs/monitoring_lab"
  resource_group_name   = azurerm_resource_group.primary.name
  location              = azurerm_resource_group.primary.location
  app_name              = var.app_name
  env_name              = var.env_name
}
*/

/*
module "lab_azfn" {
  source                = "./labs/azfn_lab"
  resource_group_name   = azurerm_resource_group.primary.name
  location              = azurerm_resource_group.primary.location
  app_name              = var.app_name
  env_name              = var.env_name
}
*/


module "lab_microservices" {
  source                    = "./labs/microservices_lab"
  resource_group_name       = azurerm_resource_group.primary.name
  location                  = var.primary_region
  app_name                  = var.app_name
  env_name                  = var.env_name
  failover_location         = var.secondary_region
  terraform_application_id  = var.terraform_application_id
}
output "usdl_function_key" {
    value = module.lab_microservices.usdl_function_key
}
output "usdl_function_name" {
    value = module.lab_microservices.usdl_function_name
}
output "usdl_function_eventgrid_key" {
    value = module.lab_microservices.usdl_function_eventgrid_key
}
output "drug_function_key" {
    value = module.lab_microservices.drug_function_key
}
output "drug_function_name" {
    value = module.lab_microservices.drug_function_name
}
output "patient_function_key" {
    value = module.lab_microservices.patient_function_key
}
output "patient_function_name" {
    value = module.lab_microservices.patient_function_name
}

output "apim_name" {
    value = module.lab_microservices.apim_name
}
output "apim_public_ip_address" {
    value = module.lab_microservices.apim_public_ip_address
}