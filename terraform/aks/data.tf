data "azurerm_resource_group" "resource_group" {
  name = var.resource_group
}

data "azurerm_resource_group" "hub_resource_group" {
  name = var.hub_rg
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet
  resource_group_name = var.resource_group
}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_${data.azurerm_resource_group.resource_group.location}"
  resource_group_name = "NetworkWatcherRG"
}

data "azurerm_storage_account" "vnet_storage_account" {
  name                = replace("${var.resource_group}vnetsa", "-", "")
  resource_group_name = var.resource_group
}

data "azurerm_container_registry" "container_registry" {
  name                = var.acr_login_server
  resource_group_name = var.hub_rg
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}

data "azurerm_key_vault" "rg_keyvault" {
  resource_group_name = var.resource_group
  name                = var.resource_group
}

data "azurerm_dns_zone" "tools_azure_dynamicdemand_ai" {
  name                = "tools.azure.dynamicdemand.ai"
  resource_group_name = var.hub_rg
}

data "azurerm_dns_zone" "res_azure_dynamicdemand_ai" {
  name                = "res.azure.dynamicdemand.ai"
  resource_group_name = var.hub_rg
}

data "azurerm_dns_zone" "azure_dynamicdemand_ai" {
  name                = "azure.dynamicdemand.ai"
  resource_group_name = var.hub_rg
}

data "azurerm_private_dns_zone" "rg_private_dns_zone" {
  name                = "${var.resource_group}.internal.azure.dynamicdemand.ai"
  resource_group_name = var.resource_group
}

data "azurerm_private_dns_zone" "aks_private_dns_zone" {
  name                = "${var.resource_group}.privatelink.${var.location}.azmk8s.io"
  resource_group_name = var.resource_group
}

data "azurerm_ssh_public_key" "ssh_key" {
  name                = "vm_${var.admin_username}"
  resource_group_name = var.hub_rg
}

# Created Resource

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.name
  resource_group_name = var.resource_group

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resource_group" "aks_node_resource_group" {
  name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_node_pool_vmss" {
  type                = "Microsoft.Compute/virtualMachineScaleSets"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_default_node_pool_nsg" {
  type                = "Microsoft.Network/networkSecurityGroups"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_resources" "aks_node_pool_kubelet_user-assigned-identities" {
  type                = "Microsoft.ManagedIdentity/userAssignedIdentities"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_user_assigned_identity" "aks_node_pool_kubelet_user-assigned-identities" {
  name                = data.azurerm_resources.aks_node_pool_kubelet_user-assigned-identities.resources[0].name
  resource_group_name = data.azurerm_resources.aks_node_pool_kubelet_user-assigned-identities.resource_group_name
}

data "azurerm_resources" "aks_network-interface" {
  type                = "Microsoft.Network/networkInterfaces"
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}

data "azurerm_network_interface" "aks_network_interface" {
  name                = data.azurerm_resources.aks_network-interface.resources[0].name
  resource_group_name = local.node_group_rg_name

  depends_on = [
    module.aks_cluster
  ]
}