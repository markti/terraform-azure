
module "app" {
  
  source      = "../../aad/app"
  name        = var.name
  reply_urls  = [ var.redirect_uri ] 

}
module "sp" {
  
  source          = "../../aad/sp"
  application_id  = module.app.application_id

}