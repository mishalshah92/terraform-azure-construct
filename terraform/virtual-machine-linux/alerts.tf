# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcacheredis

locals {
  alert_name = "${var.resource_group}_virtual-machine-linux_${var.name}"
}


data "azurerm_virtual_machine" "vm" {
  name                = var.name
  resource_group_name = var.resource_group

  depends_on = [
    module.linux_vm
  ]
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

# Metric alerts for CPU usage

resource "azurerm_monitor_metric_alert" "cpu_sev2" {
  name                = "${local.alert_name}_cpu_sev2"
  resource_group_name = var.resource_group
  scopes = [
    data.azurerm_virtual_machine.vm.id
  ]
  description = "Metric alerts for CPU usage - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
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

resource "azurerm_monitor_metric_alert" "cpu_sev1" {
  name                = "${local.alert_name}_cpu_sev1"
  resource_group_name = var.resource_group
  scopes = [
    data.azurerm_virtual_machine.vm.id
  ]
  description = "Metric alerts for CPU usage - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "Percentage CPU"
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

# Metric alerts for OS disk consumed

resource "azurerm_monitor_metric_alert" "os_disk_sev2" {
  name                = "${local.alert_name}_os-disk_sev2"
  resource_group_name = var.resource_group
  scopes = [
    data.azurerm_virtual_machine.vm.id
  ]
  description = "Metric alerts for OS disk iops usage - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "OS Disk IOPS Consumed Percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
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

resource "azurerm_monitor_metric_alert" "os_disk_sev1" {
  name                = "${local.alert_name}_os-disk_sev1"
  resource_group_name = var.resource_group
  scopes = [
    data.azurerm_virtual_machine.vm.id
  ]
  description = "Metric alerts for OS disk iops usage - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = "OS Disk IOPS Consumed Percentage"
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

