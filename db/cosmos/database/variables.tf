variable "resource_group_name" { }
variable "location" { }
variable "name" {
    type = string
    description = "The name used for the CosmosDB database"
}
variable "app_name" { }
variable "env_name" { }

variable "account_name" {
    type = string
}

variable "throughput" { 
    default = 400 
}