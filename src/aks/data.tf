data "azurerm_resource_group" "resource_group" {
  name = var.resource_group
}

data "azurerm_resource_group" "node_resource_group" {
  name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_${data.azurerm_resource_group.resource_group.location}"
  resource_group_name = "NetworkWatcherRG"
}

data "azurerm_storage_account" "vnet_storage_account" {
  name                = replace("${var.resource_group}vnetsa", "-", "")
  resource_group_name = var.resource_group
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}

data "azurerm_key_vault" "rg_keyvault" {
  resource_group_name = var.resource_group
  name                = var.resource_group
}

data "azurerm_private_dns_zone" "private_dns_zone" {
  name                = "${var.resource_group}.internal.azure.dynamicdemand.ai"
  resource_group_name = var.resource_group
}

# Created Resource

data "azurerm_resources" "aks_default_agent_pool_vmss" {
  type                = "Microsoft.Compute/virtualMachineScaleSets"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_nsg" {
  type                = "Microsoft.Network/networkSecurityGroups"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_dns-zone" {
  type                = "Microsoft.Network/privateDnsZones"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_public-ip" {
  type                = "Microsoft.Network/publicIPAddresses"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_user-assigned-identities" {
  type                = "Microsoft.ManagedIdentity/userAssignedIdentities"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_private-endpoints" {
  type                = "Microsoft.Network/privateEndpoints"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_agent_pool_network-interfaces" {
  type                = "Microsoft.Network/networkInterfaces"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_network_interface" "kuberentes_network_interface" {
  name                = data.azurerm_resources.aks_default_agent_pool_network-interfaces.resources[0].name
  resource_group_name = local.node_group_rg_name
}

data "azurerm_resources" "aks_default_agent_pool_loadBalancers" {
  type                = "Microsoft.Network/loadBalancers"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_addon_http_application_routing_dns-zone" {
  type                = "Microsoft.Network/dnszones"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resource_group" "aks_rg" {
  name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  resource_group_name = var.resource_group

  depends_on = [
    module.aks_cluster
  ]
}


data "azurerm_user_assigned_identity" "aks_default_agent_pool_kubelet_user-assigned-identities" {
  name                = element(split("/", module.aks_cluster.kubelet_identity.0.user_assigned_identity_id), length(split("/", module.aks_cluster.kubelet_identity.0.user_assigned_identity_id)) - 1)
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}