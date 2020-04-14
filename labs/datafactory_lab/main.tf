

/*
module "datafactory" {

  source                                = "../../etl/datafactory"

  app_name                      = var.app_name
  env_name                      = var.env_name
  
  name                          = "${var.app_name}-${var.env_name}-covid"
  resource_group_name           = var.resource_group_name
  location                      = var.location

}

//https://healthdata.gov/dataset/provisional-death-counts-coronavirus-disease-covid-19

module "ingest_storage" {
  
  source                = "../../storage/blob"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "ingest"

}
*/