variable "resource_group_name" { }
variable "location" { }
variable "name" { }
variable "app_name" { }
variable "env_name" { }
variable "service_name" { }
variable "hosting_plan_id" { }
variable "hosting_storage_connection_string" { }
variable "azure_function_version" { }
variable "worker_runtime" { }
variable "app_settings" {
    description = "An array of properties to pass into the Azure Function for its app settings collection"
}
variable "instrumentation_key" { }
variable "keyvault_id" { }
variable "deployment_storage_account_name" { }
variable "deployment_storage_container" { }
variable "deployment_package_sas" { }
variable "deployment_package_filename" { }