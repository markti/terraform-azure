output "endpoint" {
    value = azurerm_eventgrid_topic.topic.endpoint
}
output "primary_access_key" {
    value = azurerm_eventgrid_topic.topic.primary_access_key
}