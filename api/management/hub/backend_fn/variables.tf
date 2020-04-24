/* 
 *
 * This module creates a backend for an Azure Function
 * 
 *
 *  - It assumes your Azure Function is configured with the default URL template:
 *      
 *        https://YOUR_FUNCTION_NAME_HERE.azurewebsites.net/api
 * 
 *  - It assumes that your Azure Function is configured using Azure Function 
 *      Authentication. Therefore, it will add the 'x-functions-key' as an 
 *      HTTP Header credential.
 *
 *
 */
variable "resource_group_name" { }
variable "apim_name" { }
variable "name" { }
variable "function_name" { }
variable "function_key_named_value" { }
variable "protocol" { 
  default = "http"
}