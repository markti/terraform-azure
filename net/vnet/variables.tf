variable "resource_group_name" { }
variable "location" { }
variable "app_name" { }
variable "env_name" { }
variable "name" { }
variable "vnet_range" { default = "10.0.0.0/16" }
variable "subnet1_range" { default = "10.0.2.0/24" }