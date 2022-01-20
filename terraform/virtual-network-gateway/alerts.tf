# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftnetworkvirtualnetworkgateways

locals {
  alert_name = "${var.resource_group}_virtual-network-gateway_${var.name}"
}

resource "azurerm_monitor_action_group" "alert_action_group" {
  name                = local.alert_name
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

# Metric alerts for Connection count

resource "azurerm_monitor_metric_alert" "connection_count_sev3" {
  name                = "${local.alert_name}_connection-count_sev3"
  resource_group_name = var.resource_group
  scopes = [
    module.vnet_gateway.id
  ]
  description = "Metric alerts for Connection count - Sev 3."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/virtualNetworkGateways"
    metric_name      = "P2SConnectionCount"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = var.connection_count
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT30M"

  tags = local.tags
}