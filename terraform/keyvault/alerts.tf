# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis

locals {
  alert_name = "${var.resource_group}_keyvault_${var.name}"
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
  scopes              = [module.key_vault.id]
  description         = "Metric alerts for availability - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
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

# Metric alerts for service_api_latency > 3000 / 1H

resource "azurerm_monitor_metric_alert" "service_api_latency" {
  name                = "${local.alert_name}_service-api-latency_sev4"
  resource_group_name = var.resource_group
  scopes              = [module.key_vault.id]
  description         = "Metric alerts for service_api_latency - Sev 4."
  severity            = 4

  criteria {
    metric_namespace = "Microsoft.KeyVault/vaults"
    metric_name      = "ServiceApiLatency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 3000
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

