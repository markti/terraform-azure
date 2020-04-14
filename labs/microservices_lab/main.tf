

module "microservice_hub" {
  
  source                    = "../../microservices/hub"

  app_name                  = var.app_name
  env_name                  = var.env_name
  
  resource_group_name       = var.resource_group_name
  location                  = var.location
  failover_location         = var.failover_location
  terraform_application_id  = var.terraform_application_id

}

locals {
    app_settings = {
    }
}





