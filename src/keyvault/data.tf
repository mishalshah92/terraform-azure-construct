data "azurerm_subscription" "current" {}

data "azuread_users" "users" {
  user_principal_names = var.admin_user_principal_names
}

data "azuread_groups" "groups" {
  names = var.admin_user_groups
}

data "azurerm_subnet" "allowed_subnet" {

  for_each = var.network_subnet_map

  name                 = each.value.name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = var.resource_group
}

data "azurerm_role_definition" "key_vault_administrator" {
  name = "Key Vault Administrator"
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}