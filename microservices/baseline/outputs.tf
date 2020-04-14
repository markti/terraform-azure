/*
output "code_drop_url" {
  value = local.code_drop_url
}
*/
output "function_name" {
    value = module.api_fn.name
}
output "function_key" {
    value = module.api_fn.function_key
}
output "function_eventgrid_key" {
    value = module.api_fn.eventgrid_key
}
output "api_name" {
    value = module.fn_apim_api.api_name
}