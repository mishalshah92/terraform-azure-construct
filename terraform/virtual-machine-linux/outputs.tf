output "id" {
  value = data.azurerm_virtual_machine.vm.id
}

output "private_ip_address" {
  value = module.linux_vm.private_ip_address
}

output "virtual_machine_id" {
  value = module.linux_vm.virtual_machine_id
}

output "virtual_machine_user_identity" {
  value = azurerm_user_assigned_identity.vm_user_identity.name
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}