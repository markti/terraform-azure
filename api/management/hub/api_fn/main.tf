

module "fn_apim_api_baseline" {
  
  source                = "../api_baseline"
  
  resource_group_name   = var.resource_group_name
  apim_name             = var.apim_name
  name                  = var.name
  description           = var.description
  revision              = var.revision
  path                  = var.path
  primary_protocol      = var.primary_protocol
  backend_name          = module.fn_apim_backend.name
  product_id            = var.product_id

}

module "fn_apim_backend" {
  
  source                = "../backend_fn"
  
  resource_group_name   = var.resource_group_name
  apim_name             = var.apim_name
  name                  = var.name
  function_name         = var.function_name
  function_key          = var.function_key
  protocol              = "http"

}

/*
module "fn_key" {
  
  source                = "../named_value"
  
  resource_group_name   = var.resource_group_name
  apim_name             = var.apim_name
  name                  = var.name
  value                 = var.function_key
  secret                = "true"

}
*/