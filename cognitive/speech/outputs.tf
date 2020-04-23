
output "access_key" {
    value = azurerm_cognitive_account.cognitive_speech.primary_access_key
}
output "endpoint" {
    value = azurerm_cognitive_account.cognitive_speech.endpoint
}
