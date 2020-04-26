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
output "hostname" {
    value = "${module.api_fn.hostname}"
}
output "topic_id" {
    value = "${module.api_eventgrid_topic.id}"
}