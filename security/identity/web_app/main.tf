
module "app" {
  
  source              = "../../aad/app"
  name                = var.name
  reply_urls          = var.reply_urls
  allow_implicit_flow = true

}
module "sp" {
  
  source          = "../../aad/sp"
  application_id  = module.app.application_id

}