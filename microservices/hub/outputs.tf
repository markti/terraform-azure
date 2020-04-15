output "hosting_plan_id" {
  value = module.api_hosting_plan.id
}
output "storage_connection_string" {
  value = module.api_hosting_plan.storage_connection_string
}
/*
output "database_connection_string" {
  value = module.cosmosdb_account.connection_strings[0]
}
output "database_name" {
  value = module.cosmosdb_database.name
}
*/

output "instrumentation_key" {
  value = module.appinsights.instrumentation_key
}

output "keyvault_id" {
  value = module.keyvault.id
}

output "code_storage_account_name" {
  value = module.code_storage.name
}
output "code_storage_container" {
  value = azurerm_storage_container.code_storage.name
}
output "code_storage_sas" {
  value = data.azurerm_storage_account_sas.code_storage.sas
}


output "apim_name" {
  value = module.api_management.name
}
// there should only be one
output "apim_public_ip_address" {
  value = module.api_management.public_ip_addresses[0]
}