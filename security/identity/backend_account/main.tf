
module "app" {
  
  source  = "../../aad/app"
  name    = var.name
  identifier_uris  = [ var.application_id_uri ] 

}
module "sp" {
  
  source          = "../../aad/sp"
  application_id  = module.app.application_id

}