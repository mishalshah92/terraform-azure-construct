resource "azurerm_user_assigned_identity" "user_identity" {
  name                = "${var.module}_${data.azurerm_kubernetes_cluster.aks.name}_${var.name}_nodepool"
  resource_group_name = data.azurerm_kubernetes_cluster.aks.node_resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "user_identity_role_assignments" {

  for_each = var.user_identity

  scope                = each.key
  role_definition_name = each.value
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id
}