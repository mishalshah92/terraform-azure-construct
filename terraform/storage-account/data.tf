data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}

data "azurerm_subnet" "allowed_subnet" {

  for_each = var.vnet_rule_allowed_subnet_names

  name                 = each.value.name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group
}