
module "app" {
  
  source      = "../../aad/app"
  name        = var.name
  reply_urls  = var.reply_urls

}
module "sp" {
  
  source          = "../../aad/sp"
  application_id  = module.app.application_id

}