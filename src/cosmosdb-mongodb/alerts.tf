# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis

locals {
  alert_name = "${var.resource_group}_cosmosdb-mongodb_${var.name}"
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

# Metric alerts for a any change in network settings > 1 / 5 min

resource "azurerm_monitor_metric_alert" "update_network_setting" {
  name                = "${local.alert_name}_update-network-setting_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.cosmosdb_account.id]
  description         = "Metric alerts for a any change in network settings - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "UpdateAccountNetworkSettings"
    aggregation      = "Count"
    operator         = "GreaterThanOrEqual"
    threshold        = 1
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT5M"

  tags = local.tags
}

# Metric alerts for a server side latency > 5 MilliSeconds / 15 min

resource "azurerm_monitor_metric_alert" "server_side_latency" {
  name                = "${local.alert_name}_server-side-latency_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.cosmosdb_account.id]
  description         = "Metric alerts for a server side latency > 5 MilliSeconds - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "ServerSideLatency"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 5
  }

  window_size = "PT15M"

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}


# Metric alerts for CosmosDB service availability < 100% / 5 min

resource "azurerm_monitor_metric_alert" "service_availability" {
  name                = "${local.alert_name}_service-availability_sev1"
  resource_group_name = var.resource_group
  scopes              = [module.cosmosdb_account.id]
  description         = "Metric alerts for CosmosDB service availability < 100% - Sev 1."
  severity            = 1

  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "ServiceAvailability"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 100
  }

  window_size = "PT1H"

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

# Metric alerts for CosmosDB Mongo Collection Throughput Updated > 1 / 5 min

resource "azurerm_monitor_metric_alert" "mongo_collection_throughput_updated" {
  name                = "${local.alert_name}_mongo-collection-throughput-updated_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.cosmosdb_account.id]
  description         = "Metric alerts for CosmosDB Mongo Collection Throughput Updated - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "MongoCollectionThroughputUpdate"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 1
  }

  window_size = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}


# Metric alerts for CosmosDB Mongo Database Throughput Updated > 1 / 5 min

resource "azurerm_monitor_metric_alert" "mongo_database_throughput_updated" {
  name                = "${local.alert_name}_mongo-database-throughput-updated_sev3"
  resource_group_name = var.resource_group
  scopes              = [module.cosmosdb_account.id]
  description         = "Metric alerts for CosmosDB Mongo Collection Throughput Updated - Sev 3."
  severity            = 3

  criteria {
    metric_namespace = "Microsoft.DocumentDB/databaseAccounts"
    metric_name      = "MongoDatabaseThroughputUpdate"
    aggregation      = "Count"
    operator         = "GreaterThan"
    threshold        = 1
  }

  window_size = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  tags = local.tags
}

