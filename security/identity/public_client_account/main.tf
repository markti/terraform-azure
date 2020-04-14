
module "app" {
  
  source  = "../../aad/app"
  name    = var.name

}
module "sp" {
  
  source          = "../../aad/sp"
  application_id  = module.app.application_id

}