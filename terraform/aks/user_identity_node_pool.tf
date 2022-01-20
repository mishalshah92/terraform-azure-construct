resource "azurerm_role_assignment" "aks_node_pool_user_identity_managed_identity_operator" {

  scope                = data.azurerm_resource_group.aks_node_resource_group.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_vitual_machine_contributor" {

  scope                = data.azurerm_resource_group.aks_node_resource_group.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_rg_reader" {

  scope                = data.azurerm_resource_group.resource_group.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_disk_encryption_contributor" {

  scope                = azurerm_disk_encryption_set.disk_encryption_set.id
  role_definition_name = "Owner"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_dns_zone_contributor_azure_test_com" {

  scope                = data.azurerm_dns_zone.azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_dns_zone_contributor_tools_azure_test_com" {

  scope                = data.azurerm_dns_zone.tools_azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_dns_zone_contributor_res_azure_test_com" {

  scope                = data.azurerm_dns_zone.res_azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "aks_node_pool_user_identity_hug_rg_reader" {

  scope                = data.azurerm_resource_group.hub_resource_group.id
  role_definition_name = "Reader"
  principal_id         = data.azurerm_user_assigned_identity.aks_node_pool_kubelet_user-assigned-identities.principal_id
}