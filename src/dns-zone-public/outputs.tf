output "id" {
  value = module.dns_zone_public.id
}

output "name_servers" {
  value = module.dns_zone_public.name_servers
}

output "max_number_of_record_sets" {
  value = module.dns_zone_public.max_number_of_record_sets
}

output "number_of_record_sets" {
  value = module.dns_zone_public.number_of_record_sets
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}