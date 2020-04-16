/* 
 * This deploys an API Management API with a specified backend. It supports any backend.
 *
 *
 *  - It will add a 'set-backend-service' policy to link the backend to the API.
 *
 *  - It will link the API to the product specified by the 'product_id' input variable.
 *
 *
 * NOTE: The backend must be created **externally**
 *
 */

variable "resource_group_name" { }
variable "apim_name" { }
variable "name" { }
variable "description" { }
variable "revision" { }
variable "path" { }
variable "backend_name" { }
variable "primary_protocol" {
  type = string
  default = "https"
}
variable "product_id" { }