# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcomputevirtualmachinescalesets

### VMSS

locals {
  vmss_alert_name = "${data.azurerm_kubernetes_cluster.aks.node_resource_group}_aks_vmss_${data.azurerm_resources.aks_agent_pool_vmss.resources[0].name}"
}

# Metric alerts for VMSS CPU usage - sev2

resource "azurerm_monitor_metric_alert" "vmss_aks_node_pool_cpu_sev2" {
  name                = "${local.vmss_alert_name}_aks-${var.name}-node-pool_cpu_sev2"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  scopes = [
    data.azurerm_resources.aks_agent_pool_vmss.resources[0].id,
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

  action {
    action_group_id = data.azurerm_monitor_action_group.node_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for VMSS CPU usage - sev1

resource "azurerm_monitor_metric_alert" "vmss_aks_node_pool_cpu_sev1" {
  name                = "${local.vmss_alert_name}_aks-${var.name}-node-pool_cpu_sev1"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  scopes = [
    data.azurerm_resources.aks_agent_pool_vmss.resources[0].id,
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

  action {
    action_group_id = data.azurerm_monitor_action_group.node_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for VMSS OS disk consumed - sev2

resource "azurerm_monitor_metric_alert" "vmss_aks_node_pool_os_disk_sev2" {
  name                = "${local.vmss_alert_name}_aks-${var.name}-node-pool_os-disk_sev2"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  scopes = [
    data.azurerm_resources.aks_agent_pool_vmss.resources[0].id,
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

  action {
    action_group_id = data.azurerm_monitor_action_group.node_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}


# Metric alerts for VMSS OS disk consumed - sev1

resource "azurerm_monitor_metric_alert" "vmss_aks_node_pool_os_disk_sev1" {
  name                = "${local.vmss_alert_name}_aks-${var.name}-node-pool_os-disk_sev1"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  scopes = [
    data.azurerm_resources.aks_agent_pool_vmss.resources[0].id,
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

  action {
    action_group_id = data.azurerm_monitor_action_group.node_alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}