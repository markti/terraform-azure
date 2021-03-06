/* 
 * WRAPPER: 'api_baseline'
 *
 * This expands upon the 'api_baseline' module by layering on API Management components needed for an 
 *    Azure Function backend.
 * 
 *
 *  - It will generate the backend using the function_name and function_key properties and link it to the API.
 * 
 *  - It will create a 'Property' within Azure API Management and reference that property in the API's policy.
 *
 *
 */
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
variable "product_id" { }