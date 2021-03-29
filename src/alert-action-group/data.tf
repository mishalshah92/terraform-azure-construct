data "azurerm_logic_app_workflow" "slack_notifier_logic_app" {
  name                = var.slack_notifier_logic_app_name
  resource_group_name = var.resource_group
}