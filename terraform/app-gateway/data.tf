data "azurerm_key_vault" "ssl_cert_keyvault" {
  name                = var.ssl_cert_key_vault
  resource_group_name = var.hub_rg
}

data "azurerm_key_vault_secret" "keyvault_cert_secret" {

  for_each = toset(var.ssl_certificates)

  name         = each.value
  key_vault_id = data.azurerm_key_vault.ssl_cert_keyvault.id
}

data "azurerm_subnet" "app_gateway_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  name                = var.alert_action_group_name
  resource_group_name = var.hub_rg
}