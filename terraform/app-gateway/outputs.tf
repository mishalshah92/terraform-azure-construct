output "id" {
  value = azurerm_application_gateway.app_gateway.id
}

output "public_ip" {
  value = azurerm_public_ip.app_gateway_public_ip.ip_address
}

output "backend_address_pool" {
  value = azurerm_application_gateway.app_gateway.backend_address_pool
}

output "static_naming" {
  value = {
    "frontend_private_ip_configuration_name" = local.frontend_private_ip_configuration_name,
    "frontend_public_ip_configuration_name"  = local.frontend_public_ip_configuration_name
  }
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}