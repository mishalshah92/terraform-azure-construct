output "id" {
  value = module.mysql-db.id
}

output "name" {
  value = local.name
}

output "admin_username" {
  value = "${var.administrator_username}@${local.name}"
}

output "admin_password" {
  value = random_password.mysql_password.result
}

output "fqdn" {
  value = module.mysql-db.fqdn
}

output "identity" {
  value = module.mysql-db.identity
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