# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis

locals {
  alert_name = "${var.resource_group}_dns-zone-private_${var.name}"
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

# Metric alerts for Percent of Record Set capacity utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "record_set_capacity_utilization" {
  name                = "${local.alert_name}_record-set-capacity-utilization_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.dns_zone_private.id]
  description         = "Metric alerts for Percent of Record Set capacity utilized by a DNS zone - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
    metric_name      = "RecordSetCapacityUtilization"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.rg_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags
}

# Metric alerts for Percent of Virtual Network Link Capacity Utilization utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "virtual_network_link_capacity_utilization" {
  name                = "${local.alert_name}_virtual-network-link-capacity-utilization_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.dns_zone_private.id]
  description         = "Metric alerts for Percent of Virtual Network Link Capacity Utilization utilized by a DNS zone - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
    metric_name      = "VirtualNetworkLinkCapacityUtilization"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.rg_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags
}

# Metric alerts for Percent of Virtual Network Link Registration Capacity Utilization utilized by a DNS zone > 80% / 1H

resource "azurerm_monitor_metric_alert" "virtual_network_registration_link_capacity_utilization" {
  name                = "${local.alert_name}_virtual-network-registration-link-capacity-utilization_sev2"
  resource_group_name = var.resource_group
  scopes              = [module.dns_zone_private.id]
  description         = "Metric alerts for Percent of Virtual Network Link Registration Capacity Utilization utilized by a DNS zone - Sev 2."
  severity            = 2

  criteria {
    metric_namespace = "Microsoft.Network/privateDnsZones"
    metric_name      = "VirtualNetworkWithRegistrationCapacityUtilization"
    aggregation      = "Maximum"
    operator         = "GreaterThanOrEqual"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.rg_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags
}

