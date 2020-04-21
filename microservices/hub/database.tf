

module "cosmosdb_account" {
  
  source                = "../../db/cosmos/account"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = "${var.app_name}-${var.env_name}-cosmosdb"
  resource_group_name   = var.resource_group_name
  location              = var.location
  failover_location     = var.failover_location

}

module "cosmosdb_database" {
  
  source                = "../../db/cosmos/database"

  app_name              = var.app_name
  env_name              = var.env_name
  
  name                  = var.app_name
  resource_group_name   = var.resource_group_name
  location              = var.location

  account_name          = module.cosmosdb_account.name
  throughput            = 400

}
