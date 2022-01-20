output "id" {
  value = module.dns_zone_private.id
}

output "number_of_record_sets" {
  value = module.dns_zone_private.number_of_record_sets
}

output "max_number_of_record_sets" {
  value = module.dns_zone_private.max_number_of_record_sets
}

output "max_number_of_virtual_network_links" {
  value = module.dns_zone_private.max_number_of_virtual_network_links
}

output "max_number_of_virtual_network_links_with_registration" {
  value = module.dns_zone_private.max_number_of_virtual_network_links_with_registration
}

output "alert_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "alert_action_group_email_receiver" {
  value = azurerm_monitor_action_group.alert_action_group.email_receiver
}