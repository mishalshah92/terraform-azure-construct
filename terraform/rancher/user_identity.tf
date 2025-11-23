# VM - User Managed Identity - rancher

resource "azurerm_user_assigned_identity" "rancher_vm_user_identity" {
  name                = "${local.name}-rancher"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "rancher_vm_user_identity_acr_pull" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.rancher_vm_user_identity.principal_id
}

resource "azurerm_role_assignment" "rancher_vm_user_identity_key_vault_secrets_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.rancher_vm_user_identity.principal_id
}

resource "azurerm_role_assignment" "rancher_vm_user_identity_contributor" {

  for_each = data.azurerm_resource_group.resource_groups

  scope                = each.value.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.rancher_vm_user_identity.principal_id
}