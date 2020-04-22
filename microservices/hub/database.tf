
/*
module "secret_cosmosdb_connection_string" {
  
  source                = "../../security/secret"

  app_name              = var.app_name
  env_name              = var.env_name
  keyvault_id           = module.keyvault.id
  
  name                  = "CosmosDb-ConnectionString"
  value                 = module.cosmosdb_account.connection_strings[0]

}
*/