variable "resource_group_name" { }
variable "location" { }
variable "app_name" { }
variable "env_name" { }
variable "name" { }

variable "publisher_name" { }
variable "publisher_email" { }
variable "sku_name" { 
    default = "Developer_1"
 }
variable "cors_allowed_origins" {
    description = "List of allowed origin URLs, this allows web clients (i.e. Angular/ReactJS) to access your APIs through JavaScript."
}
variable "cors_allowed_headers" {
    description = "List of allowed HTTP Headers to be sent by clients. Sometimes you want to allow additional custom headers for reasons."
}