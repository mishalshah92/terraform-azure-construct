output "id" {
  value = module.key_vault.id
}

output "vault_uri" {
  value = module.key_vault.vault_uri
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}