# VMSS - User Managed Identity

resource "azurerm_user_assigned_identity" "vmss_user_identity" {
  name                = "${var.module}_${var.name}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "vmss_user_identity_acr_reader" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "vmss_user_identity_storage_blob_reader" {
  scope                = data.azurerm_storage_account.chartmuseum_storage_account.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "vmss_user_identity_key_vault_secrets_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.vmss_user_identity.principal_id
}