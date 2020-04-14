

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

module "user_admin" {
  
  source                = "../../api/management/hub/user"
  
  apim_name             = module.api_management.name
  resource_group_name   = var.resource_group_name
  user_id               = "admin-user"
  first_name            = "Keyser"
  last_name             = "Soze"
  email                 = "keyser_soze@persistent.com"
}


module "product_backoffice_api" {
  
  source                = "../../api/management/hub/product"

  resource_group_name   = var.resource_group_name
  apim_name             = module.api_management.name
  
  product_id            = "backoffice-api"
  description           = "Backoffice API"

}

module "subscription_web" {
  
  source                = "../../api/management/hub/subscription"

  resource_group_name   = var.resource_group_name
  apim_name             = module.api_management.name
  
  product_id            = module.product_backoffice_api.id
  description           = "Backoffice Web App Subscription"
  user_id               = module.user_admin.id

}
