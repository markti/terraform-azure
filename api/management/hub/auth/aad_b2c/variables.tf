variable "resource_group_name" { }
variable "apim_name" { }
variable "name" { }
variable "b2c_tenant_name" { }
variable "b2c_signin_policy" { 
  default = "b2c_1_susi_email"
}
variable "default_scope" { }