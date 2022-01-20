resource "azurerm_user_assigned_identity" "vm_user_identity" {
  name                = "${var.resource_group}-${var.module}-${var.deployment}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "vm_user_identity_acr_reader" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.vm_user_identity.principal_id
}

resource "azurerm_role_assignment" "vm_user_identity_storage_blob_reader" {
  scope                = data.azurerm_storage_account.app_config_storage_account.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.vm_user_identity.principal_id
}

resource "azurerm_role_assignment" "vm_user_identity_key_vault_secret_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.vm_user_identity.principal_id
}