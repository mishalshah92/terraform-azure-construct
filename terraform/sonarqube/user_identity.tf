# VMSS - User Managed Identity - nexus

resource "azurerm_user_assigned_identity" "sonarqube_vmss_user_identity" {
  name                = "${local.name}-sonarqube"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "sonarqube_vmss_user_identity_key_vault_secrets_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.sonarqube_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "sonarqube_vmss_user_identity_storage_account_contributor" {
  scope                = data.azurerm_storage_account.sonarqube_storage_account.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.sonarqube_vmss_user_identity.principal_id
}