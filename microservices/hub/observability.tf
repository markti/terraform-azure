

module "appinsights" {
  
  source                = "../../monitoring/appinsights"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-${var.location_suffix}"
  resource_group_name   = var.resource_group_name
  location              = var.location

}
