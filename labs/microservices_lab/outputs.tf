
output "usdl_function_key" {
    value = module.microservice_usdl.function_key
}
output "usdl_function_name" {
    value = module.microservice_usdl.function_name
}
output "usdl_function_eventgrid_key" {
    value = module.microservice_usdl.function_eventgrid_key
}

output "patient_function_key" {
    value = module.microservice_patient.function_key
}
output "patient_function_name" {
    value = module.microservice_patient.function_name
}

output "drug_function_key" {
    value = module.microservice_drug.function_key
}
output "drug_function_name" {
    value = module.microservice_drug.function_name
}

output "apim_name" {
    value = module.microservice_hub.apim_name
}
output "apim_public_ip_address" {
    value = module.microservice_hub.apim_public_ip_address
}