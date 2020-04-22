variable "resource_group_name" { }
variable "location" { }
variable "app_name" { }
variable "env_name" { }
variable "env_name" { }
variable "location_suffix" { }
variable "terraform_application_id" {
    description = "This is needed to allow Terraform the ability to provision secrets within the key vaults."
}