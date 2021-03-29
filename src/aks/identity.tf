resource "azurerm_role_assignment" "user_identity_role_assignments" {

  for_each = var.user_identity

  scope                = each.key
  role_definition_name = each.value
  principal_id         = data.azurerm_user_assigned_identity.aks_default_agent_pool_kubelet_user-assigned-identities.principal_id
}


resource "azurerm_role_assignment" "user_identity_managed_identity_operator" {

  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "Managed Identity Operator"
  principal_id         = data.azurerm_user_assigned_identity.aks_default_agent_pool_kubelet_user-assigned-identities.principal_id
}

resource "azurerm_role_assignment" "user_identity_vitual_machine_contributor" {

  scope                = data.azurerm_resource_group.node_resource_group.id
  role_definition_name = "Virtual Machine Contributor"
  principal_id         = data.azurerm_user_assigned_identity.aks_default_agent_pool_kubelet_user-assigned-identities.principal_id
}