locals {
  alert_group_name      = "${var.resource_group}_aks_${var.name}"
  node_alert_group_name = "${local.node_group_rg_name}_aks_${var.name}"
}

resource "azurerm_monitor_action_group" "alert_action_group" {
  name                = local.alert_group_name
  resource_group_name = var.resource_group
  short_name          = "saaiaznotify"

  dynamic "email_receiver" {
    for_each = toset(var.alert_emails)
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.key
      use_common_alert_schema = true
    }
  }

  tags = local.tags
}

resource "azurerm_monitor_action_group" "alert_action_group_resources" {
  name                = local.node_alert_group_name
  resource_group_name = local.node_group_rg_name
  short_name          = "saaiaznotify"

  dynamic "email_receiver" {
    for_each = toset(var.alert_emails)
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.key
      use_common_alert_schema = true
    }
  }

  tags = local.tags
}