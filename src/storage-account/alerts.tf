# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis

locals {
  alert_name = "${var.resource_group}_storage-account_${var.name}"
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

# Metric alerts for availability < 99% / 1H

resource "azurerm_monitor_metric_alert" "availability" {
  name                = "${local.alert_name}_availability_sev1"
  resource_group_name = var.resource_group
  scopes              = [module.vnet_storage_account.id]
  description         = "Metric alerts for availability - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "Availability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 99
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags
}

# Average time used to process a successful request by Azure Storage > 1500 / 30 min

resource "azurerm_monitor_metric_alert" "success_server_latency" {
  name                = "${local.alert_name}_success-server-latency_sev4"
  resource_group_name = var.resource_group
  scopes              = [module.vnet_storage_account.id]
  description         = "The average time used to process a successful request by Azure Storage - Sev 4."
  severity            = 4

  criteria {
    metric_namespace = "Microsoft.Storage/storageAccounts"
    metric_name      = "SuccessServerLatency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 1500
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

