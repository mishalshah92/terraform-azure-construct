output "vmss_id" {
  value = module.service_vmss.id
}

output "vm_nexus_data_path" {
  value = local.nexus_data_path
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}