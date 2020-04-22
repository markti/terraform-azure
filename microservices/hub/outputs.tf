output "hosting_plan_id" {
  value = module.api_hosting_plan.id
}
output "storage_connection_string" {
  value = module.api_hosting_plan.storage_connection_string
}
output "instrumentation_key" {
  value = module.appinsights.instrumentation_key
}
output "keyvault_id" {
  value = module.keyvault.id
}
output "keyvault_uri" {
  value = module.keyvault.uri
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