

module "service_principal" {
  
  source                        = "../../security/identity/backend_account"
  name                          = var.name

}


module "keyvault_access" {
  
  source                = "../../security/accesspolicy/machine_reader"

  keyvault_id           = var.keyvault_id
  application_id        = module.service_principal.client_id

}
