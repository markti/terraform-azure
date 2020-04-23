/*
module "fn_apim_api" {
  
  source                = "../../api/management/hub/api_fn_b2c"

  resource_group_name   = var.resource_group_name
  name                  = "${var.name}-api"
  apim_name             = var.apim_name
  description           = "${var.name} API"
  revision              = "1"
  path                  = var.api_path
  function_name         = module.api_fn.name
  function_key          = module.api_fn.function_key
  
  product_id            = var.product_id
  b2c_settings          = var.b2c_settings

}
*/