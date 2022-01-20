data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_name
  resource_group_name = var.resource_group
}

data "azurerm_subnet" "vnet_subnet" {
  name                 = var.vnet_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group
}

data "azurerm_subnet" "pod_subnet" {

  for_each = var.pod_subnet_name == null ? toset([]) : toset([1])

  name                 = var.pod_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}

data "azurerm_monitor_action_group" "node_alert_action_group" {
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  name                = "${data.azurerm_kubernetes_cluster.aks.node_resource_group}_aks_${var.aks_name}"
}

data "azurerm_resources" "aks_agent_pool_vmss" {
  type                = "Microsoft.Compute/virtualMachineScaleSets"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group

  required_tags = {
    poolName   = var.name
    Deployment = var.deployment
  }

  depends_on = [
    module.aks_node_pool
  ]
}