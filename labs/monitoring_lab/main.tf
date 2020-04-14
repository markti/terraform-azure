

module "main_vnet" {
  source                = "../../net/vnet"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "${var.app_name}-${var.env_name}"
}

module "keyvault" {
  
  source                = "../../security/keyvault"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "${var.app_name}-${var.env_name}"

}


module "labvm1" {
  
  source                        = "../../vm/linux/linux_monitor"
  resource_group_name           = var.resource_group_name
  location                      = var.location
  app_name                      = var.app_name
  env_name                      = var.env_name
  name                          = "labvm001"
  subnet_id                     = module.main_vnet.subnet1_id
  admin_username                = "labadmin"
  admin_password                = random_password.vm_password.result
  diag_endpoint                 = module.storage_diag.primary_endpoint
  log_analytics_workspace_id    = module.la_workspace.workspace_id
  log_analytics_workspace_key   = module.la_workspace.workspace_key

}


module "labvm2" {
  
  source                = "../../vm/linux/linux_baseline"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "labvm002"
  subnet_id             = module.main_vnet.subnet1_id
  admin_username        = "labadmin"
  admin_password        = random_password.vm_password.result
  diag_endpoint         = module.storage_diag.primary_endpoint

}

resource "random_password" "vm_password" {
  length            = 16
  special           = true
  override_special  = "_%@"
}

module "appinsights" {
  
  source                = "../../monitoring/appinsights"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "${var.app_name}-${var.env_name}"

}


module "la_workspace" {
  
  source                = "../../monitoring/log_analytics"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "${var.app_name}-${var.env_name}"

}

output "workspace_key" {
  value = module.la_workspace.workspace_key
}

output "workspace_id" {
  value = module.la_workspace.workspace_id
}



module "storage_diag" {
  
  source                = "../../storage/blob"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "diag"

}