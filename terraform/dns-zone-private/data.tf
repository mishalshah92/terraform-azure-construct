data "azurerm_monitor_action_group" "rg_alert_action_group" {
  resource_group_name = var.resource_group
  name                = var.resource_group
}