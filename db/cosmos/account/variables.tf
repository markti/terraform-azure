variable "resource_group_name" { }
variable "location" { }
variable "name" {
    type = string
    description = "The name used for the CosmosDB account"
}
variable "app_name" { }
variable "env_name" { }
variable "failover_location" { }