/*
module "fn_apim_api" {
  
  source                = "../../api/management/hub/api_fn_aad"

  resource_group_name   = var.resource_group_name
  name                  = "${var.name}-api"
  apim_name             = var.apim_name
  description           = "${var.name} API"
  revision              = "1"
  path                  = var.api_path
  function_name         = module.api_fn.name
  function_key          = module.api_fn.function_key
  scope                 = var.scope
  product_id            = var.product_id

}
*/