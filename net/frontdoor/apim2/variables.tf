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

/*
 * 
 */
variable "frontend_hostname" {
    description = "Hostname that will be used for the front end. frontend_hostname = foo.yourdomain.com. A CNAME must be created pointing 'foo' to 'name.azurefd.net'"
 }
variable "backend_host_header" { }
variable "backend_fqdn" { }
variable "backend_healthprobe_path" { }