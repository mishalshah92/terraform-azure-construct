# VMSS - User Managed Identity - ElasticSearch Kibana

resource "azurerm_user_assigned_identity" "elasticsearch_kibana_vmss_user_identity" {
  name                = "${local.name}-elasticsearch"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "elasticsearch_kibana_vmss_user_identity_acr_reader" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.elasticsearch_kibana_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "elasticsearch_kibana_vmss_user_identity_key_vault_secrets_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.elasticsearch_kibana_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "elasticsearch_kibana_vmss_user_identity_storage_account_contributor" {
  scope                = data.azurerm_storage_account.elasticsearch_storage_account.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.elasticsearch_kibana_vmss_user_identity.principal_id
}