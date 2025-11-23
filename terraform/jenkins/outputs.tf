output "id" {
  value = module.jenkins_master_vm_scaleset.id
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}

output "vm_jenkins_data_path" {
  value = local.jenkins_data_path
}