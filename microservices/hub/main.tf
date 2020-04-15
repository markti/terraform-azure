

module "api_hosting_plan" {
  
  source                = "../../api/host/serverless"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-plan"
  resource_group_name   = var.resource_group_name
  location              = var.location

}

module "api_management" {
  
  source                = "../../api/management/hub/apim"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-apim"
  resource_group_name   = var.resource_group_name
  location              = var.location
  publisher_name        = "Demo Publisher"
  publisher_email       = "demo@persistent.com"
  sku_name              = "Developer_1"
  cors_allowed_origins  = [ "https://localhost:44329", "http://localhost:58560/"] 
  cors_allowed_headers  = [ "TENANT_ID" ]
}
