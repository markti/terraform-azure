


module "op_get_all" {

	source                              = "../parameters_0"
	resource_group_name                 = var.resource_group_name
    operation_id                        = "${var.op_prefix}-get-all"
    apim_name                           = var.apim_name
    api_name                            = var.api_name
    backend_name                        = var.backend_name
	display_name                        = "${var.entity_type} GET ALL"
    description                         = "Get all ${var.entity_type}"
    method                              = "GET"
    url_template                        = var.url_template
	
}

module "op_get" {

	source                              = "../parameters_1"
	resource_group_name                 = var.resource_group_name
    operation_id                        = "${var.op_prefix}-get"
    apim_name                           = var.apim_name
    api_name                            = var.api_name
    backend_name                        = var.backend_name
	display_name                        = "${var.entity_type} GET"
    description                         = "Get a ${var.entity_type}"
    method                              = "GET"
    url_template                        = "${var.url_template}/{${var.parameter_1}}"
    parameter_1                         = var.parameter_1
	
}

module "op_post" {

	source                              = "../parameters_0"
	resource_group_name                 = var.resource_group_name
    operation_id                        = "${var.op_prefix}-post"
    apim_name                           = var.apim_name
    api_name                            = var.api_name
    backend_name                        = var.backend_name
	display_name                        = "${var.entity_type} POST"
    description                         = "Create a ${var.entity_type}"
    method                              = "POST"
    url_template                        = var.url_template
    
}


module "op_put" {

	source                              = "../parameters_1"
	resource_group_name                 = var.resource_group_name
    operation_id                        = "${var.op_prefix}-put"
    apim_name                           = var.apim_name
    api_name                            = var.api_name
    backend_name                        = var.backend_name
	display_name                        = "${var.entity_type} PUT"
    description                         = "Update a ${var.entity_type}"
    method                              = "PUT"
    url_template                        = "${var.url_template}/{${var.parameter_1}}"
    parameter_1                         = var.parameter_1
	
}


module "op_del" {

	source                              = "../parameters_1"
	resource_group_name                 = var.resource_group_name
    operation_id                        = "${var.op_prefix}-del"
    apim_name                           = var.apim_name
    api_name                            = var.api_name
    backend_name                        = var.backend_name
	display_name                        = "${var.entity_type} DELETE"
    description                         = "Delete a ${var.entity_type}"
    method                              = "DELETE"
    url_template                        = "${var.url_template}/{${var.parameter_1}}"
    parameter_1                         = var.parameter_1

}