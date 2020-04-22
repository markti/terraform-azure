

module "api_hosting_plan" {
  
  source                = "../../api/host/serverless"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-plan"
  resource_group_name   = var.resource_group_name
  location              = var.location

}
