variable "resource_group_name" { }
variable "apim_name" { }
variable "name" { }
variable "tenant_name" { }
variable "signin_policy" { 
  default = "b2c_1_susi_email"
}
variable "client_id" { }
variable "client_secret" { }
variable "default_scope" { }
