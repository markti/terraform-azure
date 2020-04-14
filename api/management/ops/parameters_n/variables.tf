variable "resource_group_name" {}
variable "operation_id" {}
variable "apim_name" {}
variable "api_name" {}
variable "backend_name" {}
variable "display_name" {}
variable "description" {}
variable "method" {}
variable "url_template" {}
variable "url_template_parameters" {
  type = object({ 
    name        = string
    required    = bool
    type        = string
  })
}