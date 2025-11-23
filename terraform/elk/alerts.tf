# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcomputevirtualmachinescalesets
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftnetworkapplicationgateways

locals {
  alert_name = "${var.resource_group}_${local.module}_${var.name}"
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

### VMSS

# Metric alerts for VMSS CPU usage - sev2

resource "azurerm_monitor_metric_alert" "vms_cpu_sev2" {
  name                = "${local.alert_name}_cpu_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.elasticsearch_kibana_vm_scaleset.id,
  ]
  description = "Metric alerts for CPU usage - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for VMSS CPU usage - sev1

resource "azurerm_monitor_metric_alert" "vms_cpu_sev1" {
  name                = "${local.alert_name}_cpu_sev1"
  resource_group_name = var.resource_group
  scopes = [
    module.elasticsearch_kibana_vm_scaleset.id,
  ]
  description = "Metric alerts for CPU usage - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90

    dimension {
      name     = "VMName"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for VMSS OS disk consumed - sev2

resource "azurerm_monitor_metric_alert" "vmss_os_disk_sev2" {
  name                = "${local.alert_name}_os-disk_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.elasticsearch_kibana_vm_scaleset.id
  ]
  description = "Metric alerts for VMSS OS disk consumed - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "OS Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80

    dimension {
      name     = "VMName"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for VMSS OS disk consumed - sev1

resource "azurerm_monitor_metric_alert" "vmss_os_disk_sev1" {
  name                = "${local.alert_name}_os-disk_sev1"
  resource_group_name = var.resource_group
  scopes = [
    module.elasticsearch_kibana_vm_scaleset.id
  ]
  description = "Metric alerts for VMSS OS disk consumed - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachineScaleSets"
    metric_name      = "OS Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 90
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}
