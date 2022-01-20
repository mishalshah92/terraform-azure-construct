# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftnetworkdnszones

locals {
  aks_alert_name = "${var.resource_group}_aks_${var.name}"
}

# Total number of available cpu cores in a managed cluster

resource "azurerm_monitor_metric_alert" "aks_kube-node-status-allocatable-cpu-cores_sev2" {
  name                = "${local.aks_alert_name}_kube-node-status-allocatable-cpu-cores_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Total number of available cpu cores in a managed cluster - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_allocatable_cpu_cores"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 5
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

resource "azurerm_monitor_metric_alert" "aks_kube-node-status-allocatable-cpu-cores_sev1" {
  name                = "${local.aks_alert_name}_kube-node-status-allocatable-cpu-cores_sev1"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Total number of available cpu cores in a managed cluster - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_allocatable_cpu_cores"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 2
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

# Total amount of available memory in a managed cluster

resource "azurerm_monitor_metric_alert" "aks_kube_node_status_allocatable_memory_bytes_sev2" {
  name                = "${local.aks_alert_name}_kube_node_status_allocatable_memory_bytes_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Total amount of available memory in a managed cluster - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_allocatable_memory_bytes"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 10737418240 # 10GB
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

resource "azurerm_monitor_metric_alert" "aks_kube_node_status_allocatable_memory_bytes_sev1" {
  name                = "${local.aks_alert_name}_kube_node_status_allocatable_memory_bytes_sev1"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Total amount of available memory in a managed cluster - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_allocatable_memory_bytes"
    aggregation      = "Average"
    operator         = "LessThanOrEqual"
    threshold        = 5368709120 # 5GB
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

# Statuses [DiskPressure, MemoryPressure, PIDPressure] for various node conditions

resource "azurerm_monitor_metric_alert" "aks_kube_node_status_condition_sev2" {
  name                = "${local.aks_alert_name}_kube_node_status_condition_sev2"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Statuses [DiskPressure, MemoryPressure, PIDPressure] for various node conditions - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_node_status_condition"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "condition"
      operator = "Include"
      values = [
        "DiskPressure",
        "MemoryPressure",
        "PIDPressure"
      ]
    }

    dimension {
      name     = "status"
      operator = "Include"
      values = [
        "true"
      ]
    }

    dimension {
      name     = "node"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT1H"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

# Number of pods by phase [Failed, Pending, Unknown]

resource "azurerm_monitor_metric_alert" "aks_kube_pod_status_phase_sev3" {
  name                = "${local.aks_alert_name}_kube_pod_status_phase_sev3"
  resource_group_name = var.resource_group
  scopes = [
    module.aks_cluster.id
  ]
  description = "Number of pods by phase [Failed, Pending, Unknown] - Sev 3."
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "kube_pod_status_phase"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 0

    dimension {
      name     = "phase"
      operator = "Include"
      values = [
        "Failed",
        "Pending",
        "Unknown"
      ]
    }

    dimension {
      name     = "namespace"
      operator = "Include"
      values = [
        "*"
      ]
    }

    dimension {
      name     = "pod"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags

  depends_on = [
    module.aks_cluster
  ]
}

