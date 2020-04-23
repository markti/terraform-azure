output "workspace_key" {
  value = azurerm_log_analytics_workspace.workspace.primary_shared_key
}

output "workspace_id" {
  value = azurerm_log_analytics_workspace.workspace.id
}

output "workspace_name" {
  value = azurerm_log_analytics_workspace.workspace.name
}
