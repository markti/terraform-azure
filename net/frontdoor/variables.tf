variable "name" {
    type = string
    description = "The name used for the Azure Function Resource"
}
variable "location" {    
    type = string
    description = "The Azure Region to deploy into"
}
variable "resource_group_name" {    
    type = string
    description = "The Azure Resource Group to deploy into"
}
variable "app_name" { }
variable "env_name" { }

variable "frontend_hostname" { }
variable "backend_host_header" { }
variable "backend_fqdn" { }
