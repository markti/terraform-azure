

module "keyvault" {
  
  source                = "../../security/keyvault"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-${var.location_suffix}"
  resource_group_name   = var.resource_group_name
  location              = var.location

}


module "terraform_admin" {
  
  source                = "../../security/accesspolicy/machine_admin"

  keyvault_id           = module.keyvault.id
  application_id        = var.terraform_application_id

}