
locals {

  code_drop_prefix = "https://${var.deployment_storage_account_name}.blob.core.windows.net/${var.deployment_storage_container}"
  code_drop_url = "${local.code_drop_prefix}/${azurerm_storage_blob.deployment_blob.name}${var.deployment_package_sas}"

}


resource "azurerm_storage_blob" "deployment_blob" {
  name                    = "${var.name}.zip"
  storage_account_name    = var.deployment_storage_account_name
  storage_container_name  = var.deployment_storage_container
  type                    = "Block"
  source                  = var.deployment_package_filename
}
