output "aks_id" {
  value = module.aks_cluster.id
}

output "aks_fqdn" {
  value = module.aks_cluster.fqdn
}

output "aks_private_fqdn" {
  value = module.aks_cluster.private_fqdn
}

output "aks_vpn_fqdn" {
  value = azurerm_dns_a_record.aks_public_dns_zone_record.fqdn
}

output "aks_node_resource_group" {
  value = module.aks_cluster.node_resource_group
}

output "aks_user_managed_identity" {
  value = azurerm_user_assigned_identity.aks_master_user_identity.name
}

output "aks_node_pool_user_managed_identity" {
  value = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.name
}