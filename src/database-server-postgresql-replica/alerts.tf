locals {
  alert_name = "${var.resource_group}_database-server-postgresql-replica_${var.name}"
}

resource "azurerm_monitor_metric_alert" "cpu_alerts_sev2" {
  name                = "${local.alert_name}_cpu-percent_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.postgresql-db-replica.id
  ]
  description = "Action will be triggered when CPU percentage > 80%."

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = "cpu_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  severity    = 2
  window_size = "PT15M"

  action {
    action_group_id = data.azurerm_monitor_action_group.master_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "memory_alerts_sev2" {
  name                = "${local.alert_name}_memory-percent_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.postgresql-db-replica.id
  ]
  description = "Action will be triggered when memory usage > 80%."

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = "memory_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  severity    = 2
  window_size = "PT15M"

  action {
    action_group_id = data.azurerm_monitor_action_group.master_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "storage_alerts_sev2" {
  name                = "${local.alert_name}_storage-percent_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.postgresql-db-replica.id
  ]
  description = "Action will be triggered when storage > 80%."

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = "storage_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  severity    = 2
  window_size = "PT15M"

  action {
    action_group_id = data.azurerm_monitor_action_group.master_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "io_alerts_sev3" {
  name                = "${local.alert_name}_io-percent_sev3"
  resource_group_name = var.resource_group
  scopes = [
    module.postgresql-db-replica.id
  ]
  description = "Action will be triggered when io usage > 80%."

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = "io_consumption_percent"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  severity    = 3
  window_size = "PT15M"

  action {
    action_group_id = data.azurerm_monitor_action_group.master_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "backup_storage_alerts_sev2" {
  name                = "${local.alert_name}_backup-storage-percent_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.postgresql-db-replica.id
  ]
  description = "Action will be triggered when backup storage > 80% Bytes of allocation storage."

  criteria {
    metric_namespace = "Microsoft.DBforPostgreSQL/servers"
    metric_name      = "backup_storage_used"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = ((var.storage_mb * 1000000) * 80) / 100
  }

  severity    = 2
  window_size = "PT30M"

  action {
    action_group_id = data.azurerm_monitor_action_group.master_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}