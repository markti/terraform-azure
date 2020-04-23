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