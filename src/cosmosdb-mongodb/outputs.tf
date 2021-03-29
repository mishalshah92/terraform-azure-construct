output "id" {
  value = module.cosmosdb_account.id
}

output "endpoint" {
  value = module.cosmosdb_account.endpoint
}

output "read_endpoints" {
  value = module.cosmosdb_account.read_endpoints
}

output "write_endpoints" {
  value = module.cosmosdb_account.write_endpoints
}

output "connection_strings" {
  value = module.cosmosdb_account.connection_strings
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}

output "keyvault_secret_name_prefix" {
  value = local.keyvault_secret_name
}