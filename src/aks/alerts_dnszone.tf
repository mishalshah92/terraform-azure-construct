# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftnetworkdnszones

locals {
  dnszone_alert_name = "${local.node_group_rg_name}_aks_dns-zone-public_${data.azurerm_resources.aks_addon_http_application_routing_dns-zone.resources[0].name}"
}

# Metric alerts for a any change in network settings > 80% / 1H

resource "azurerm_monitor_metric_alert" "dnszone_record_set_capacity_utilization" {
  name                = "${local.dnszone_alert_name}_record-set-capacity-utilization_sev2"
  resource_group_name = local.node_group_rg_name
  scopes = [
    data.azurerm_resources.aks_addon_http_application_routing_dns-zone.resources[0].id
  ]
  description = "Metric alerts for Percent of Record Set capacity utilized by a DNS zone - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/dnszones"
    metric_name      = "RecordSetCapacityUtilization"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group_resources.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags
}

