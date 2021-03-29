# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#privateDnsZones

locals {
  dnszone_private_alert_name = "${local.node_group_rg_name}_aks_dns-zone-private_${data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].name}"
}

# Metric alerts for Percent of Record Set capacity utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "dnszone_private_record_set_capacity_utilization" {
  name                = "${local.dnszone_private_alert_name}_record-set-capacity-utilization_sev2"
  resource_group_name = local.node_group_rg_name
  scopes = [
    data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].id
  ]
  description = "Metric alerts for Percent of Record Set capacity utilized by a DNS zone - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
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

# Metric alerts for Percent of Virtual Network Link Capacity Utilization utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "dnszone_private_virtual_network_link_capacity_utilization" {
  name                = "${local.dnszone_private_alert_name}_virtual-network-link-capacity-utilization_sev2"
  resource_group_name = local.node_group_rg_name
  scopes = [
    data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].id
  ]
  description = "Metric alerts for Percent of Virtual Network Link Capacity Utilization utilized by a DNS zone - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
    metric_name      = "VirtualNetworkLinkCapacityUtilization"
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

# Metric alerts for Percent of Virtual Network Link Registration Capacity Utilization utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "dnszone_private_virtual_network_registration_link_capacity_utilization" {
  name                = "${local.dnszone_private_alert_name}_virtual-network-registration-link-capacity-utilization_sev2"
  resource_group_name = local.node_group_rg_name
  scopes = [
    data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].id
  ]
  description = "Metric alerts for Percent of Virtual Network Link Registration Capacity Utilization utilized by a DNS zone - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
    metric_name      = "VirtualNetworkWithRegistrationCapacityUtilization"
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

