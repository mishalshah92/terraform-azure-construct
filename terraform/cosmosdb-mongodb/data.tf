data "azurerm_subnet" "vnet_subnet" {

  for_each = var.virtual_network_rule

  name                 = each.key
  virtual_network_name = each.value.vnet
  resource_group_name  = each.value.resource_group
}

data "azurerm_subnet" "db_subnet" {

  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.resource_group
}

data "azurerm_key_vault" "keyvault" {
  name                = var.keyvault_name == null ? var.resource_group : var.keyvault_name
  resource_group_name = var.resource_group
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}