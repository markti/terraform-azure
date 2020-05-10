resource "azurerm_log_analytics_workspace" "workspace" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  retention_in_days   = 30

  tags = {
    app = var.app_name
    env = var.env_name
  }
}


/*
resource "azurerm_log_analytics_solution" "solution_vminsights" {
  solution_name         = "VMInsights"
  location              = var.location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = azurerm_log_analytics_workspace.workspace.id
  workspace_name        = azurerm_log_analytics_workspace.workspace.name

  plan {
    publisher       = "Microsoft"
    product         = "OMSGallery/VMInsights"
    promotion_code  = ""
  }
}
*/

/*
resource "azurerm_log_analytics_solution" "solution" {
  solution_name         = "ContainerInsights"
  location              = azurerm_resource_group.example.location
  resource_group_name   = azurerm_resource_group.example.name
  workspace_resource_id = azurerm_log_analytics_workspace.example.id
  workspace_name        = azurerm_log_analytics_workspace.example.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/ContainerInsights"
  }
}*/