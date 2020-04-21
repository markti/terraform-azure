variable "resource_group_name" { }
variable "location" { }
variable "app_name" { }
variable "env_name" { }
variable "failover_location" { }
variable "terraform_application_id" {
    description = "This is needed to allow Terraform the ability to provision secrets within the key vaults."
 }
 variable "frontend_hostname" { }