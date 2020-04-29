
module "code_storage" {
  
  source                = "../../storage/blob"
  resource_group_name   = var.resource_group_name
  location              = var.location
  app_name              = var.app_name
  env_name              = var.env_name
  name                  = "code"

}

resource "azurerm_storage_container" "code_storage" {
  name                    = "drop"
  storage_account_name    = module.code_storage.name
  container_access_type   = "private"
}

/* Generates a Blob SAS Token that can be used by the Azure Function to securely access the deployment package */

data "azurerm_storage_account_sas" "code_storage" {
  
  connection_string = module.code_storage.primary_connection_string
  https_only        = true

  resource_types {
    service   = false
    container = false
    object    = true
  }

  services {
    blob  = true
    queue = false
    table = false
    file  = false
  }

  start  = timestamp()
  expiry = timeadd(timestamp(), "2160h")

  permissions {
    read    = true
    write   = false
    delete  = false
    list    = false
    add     = false
    create  = false
    update  = false
    process = false
  }
}
