variable "resource_group_name" { }
variable "apim_name" { }
variable "name" { }
variable "description" { }
variable "revision" { }
variable "path" { }
variable "function_name" { }
variable "function_key" { }
variable "primary_protocol" {
  type = string
  default = "https"
}
variable "client_id" { }