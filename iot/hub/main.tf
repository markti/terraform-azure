
resource "azurerm_iothub" "iot_hub" {
  name                = "${var.name}-${var.location_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "S1"
    capacity = "1"
  }

}

resource "azurerm_iothub_dps" "iot_hub_prov" {
  name                = "${var.name}-provision-${var.location_suffix}"
  resource_group_name = var.resource_group_name
  location            = var.location

  sku {
    name     = "S1"
    capacity = "1"
  }

  linked_hub {
      connection_string     = "HostName=${azurerm_iothub.iot_hub.hostname};SharedAccessKeyName=${azurerm_iothub.iot_hub.shared_access_policy[0].key_name};SharedAccessKey=${azurerm_iothub.iot_hub.shared_access_policy[0].primary_key}"
      location              = var.location
  }

}

/* read only set */
resource "azurerm_iothub_dps_shared_access_policy" "iot_hub_prov_accesspol" {

  name                  = "admin-webapi"
  resource_group_name   = var.resource_group_name
  iothub_dps_name       = azurerm_iothub_dps.iot_hub_prov.name
  
  enrollment_read       = true
  enrollment_write      = true
  registration_read     = true
  registration_write    = true
}

/* TBD until the device provisioning shared access policy is fixed Github 
    https://github.com/terraform-providers/terraform-provider-azurerm/issues/5674
    
    MANUALLY MANAGE THIS
*/
/*
resource "azurerm_key_vault_secret" "secret_iotdps_connstr" {
  name         = "DeviceProvisioning-ConnectionString"
  value        = "TBD"
  //value        = azurerm_iothub_dps_shared_access_policy.iot_hub_prov_accesspol.primary_connection_string
  key_vault_id = var.keyvault_id

  depends_on = [azurerm_iothub_dps_shared_access_policy.iot_hub_prov_accesspol]
}
*/