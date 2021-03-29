output "id" {
  value = module.aks_cluster.id
}

output "fqdn" {
  value = var.private_cluster_enabled ? module.aks_cluster.private_fqdn : module.aks_cluster.fqdn
}

output "private_fqdn" {
  value = module.aks_cluster.private_fqdn
}

output "node_resource_group" {
  value = module.aks_cluster.node_resource_group
}

output "kubernetes_server_url" {
  value = azurerm_dns_a_record.tools_dns_zone_record.fqdn
}

output "kubelet_identity" {
  value = module.aks_cluster.kubelet_identity
}

output "resources" {
  value = [
    data.azurerm_resources.aks_default_agent_pool_vmss.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_nsg.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_public-ip.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_public-ip.resources[1].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[1].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[2].id,
    data.azurerm_resources.aks_default_agent_pool_loadBalancers.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_private-endpoints.resources[0].id,
    data.azurerm_resources.aks_addon_http_application_routing_dns-zone.resources[0].id
  ]
}

output "flow_log_id" {
  value = module.nsg-flow-logs.id
}

output "flow_log_vnet_storage_account_id" {
  value = data.azurerm_storage_account.vnet_storage_account.id
}

output "monitor_action_group_name" {
  value = azurerm_monitor_action_group.alert_action_group.name
}

output "monitor_action_group_resources_name" {
  value = azurerm_monitor_action_group.alert_action_group_resources.name
}

output "alerts" {
  value = [
    azurerm_monitor_metric_alert.vmss_aks_node_pool_cpu_sev1.name,
    azurerm_monitor_metric_alert.vmss_aks_node_pool_cpu_sev2.name,
    azurerm_monitor_metric_alert.vmss_aks_node_pool_os_disk_sev1.name,
    azurerm_monitor_metric_alert.vmss_aks_node_pool_os_disk_sev2.name,
    azurerm_monitor_metric_alert.dnszone_private_record_set_capacity_utilization.name,
    azurerm_monitor_metric_alert.dnszone_private_virtual_network_link_capacity_utilization.name,
    azurerm_monitor_metric_alert.dnszone_private_virtual_network_registration_link_capacity_utilization.name,
    azurerm_monitor_metric_alert.dnszone_record_set_capacity_utilization.name,
    azurerm_monitor_metric_alert.aks_kube-node-status-allocatable-cpu-cores_sev1.name,
    azurerm_monitor_metric_alert.aks_kube-node-status-allocatable-cpu-cores_sev2.name,
    azurerm_monitor_metric_alert.aks_kube_node_status_allocatable_memory_bytes_sev1.name,
    azurerm_monitor_metric_alert.aks_kube_node_status_allocatable_memory_bytes_sev2.name,
    azurerm_monitor_metric_alert.aks_kube_node_status_condition_sev2.name,
    azurerm_monitor_metric_alert.aks_kube_pod_status_phase_sev3.name
  ]
}