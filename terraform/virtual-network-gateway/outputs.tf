output "id" {
  value = module.vnet_gateway.id
}

output "ip_address" {
  value = module.vnet_gateway.ip_address
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}