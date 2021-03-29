# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis
# - https://azure.microsoft.com/en-in/pricing/details/cache/

locals {
  alert_name = "${var.resource_group}_cache-redis_${var.name}"
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

# Metric alerts for a Redis Instance with high Memory Usage

resource "azurerm_monitor_metric_alert" "memory_monitoring_sev3" {
  name                = "${local.alert_name}_memory-monitoring_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "memory_monitoring_sev2" {
  name                = "${local.alert_name}_memory-monitoring_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 70
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "memory_monitoring_sev1" {
  name                = "${local.alert_name}_memory-monitoring_sev1"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Memory Usage - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "UsedMemoryPercentage"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for a Redis Instance with high Processor Time Usage

resource "azurerm_monitor_metric_alert" "high_processor_sev3" {
  name                = "${local.alert_name}_high-processor_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 50
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "high_processor_sev2" {
  name                = "${local.alert_name}_high-processor_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 70
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "high_processor_sev1" {
  name                = "${local.alert_name}_high-processor_sev1"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis Instance with high Processor Time Usage - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "PercentProcessorTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for a Redis connected clients

resource "azurerm_monitor_metric_alert" "connected_clients_sev3" {
  name                = "${local.alert_name}_connected-clients_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis connected client reach to 50% - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "ConnectedClients"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = (var.max_number_of_client_conn / 2)
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

resource "azurerm_monitor_metric_alert" "connected_clients_sev2" {
  name                = "${local.alert_name}_connected-clients_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis connected client reach to 75% - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "ConnectedClients"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = (var.max_number_of_client_conn * 75) / 100
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

resource "azurerm_monitor_metric_alert" "connected_clients_sev1" {
  name                = "${local.alert_name}_connected-clients_sev1"
  resource_group_name = var.resource_group
  scopes              = [module.redis_cache.id]
  description         = "Metric alerts for a Redis connected client reach to 90% - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.Cache/Redis"
    metric_name      = "ConnectedClients"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = (var.max_number_of_client_conn * 90) / 100
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