# AKS - User Managed Identity

resource "azurerm_user_assigned_identity" "aks_master_user_identity" {
  name                = "${var.module}-${var.resource_group}-${var.deployment}_${var.name}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "aks_master_user_identity_acr_reader" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_key_vault_secret_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_private_dns_zone_contributor" {
  scope                = data.azurerm_private_dns_zone.aks_private_dns_zone.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_rg_reader" {

  scope                = data.azurerm_resource_group.resource_group.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_net_contributor" {

  scope                = data.azurerm_virtual_network.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_dns_zone_contributor_azure_test_com_ai" {

  scope                = data.azurerm_dns_zone.azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_dns_zone_contributor_tools_azure_test_com" {

  scope                = data.azurerm_dns_zone.tools_azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}

resource "azurerm_role_assignment" "aks_master_user_identity_dns_zone_contributor_res_azure_test_com" {

  scope                = data.azurerm_dns_zone.res_azure_test_com.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_master_user_identity.principal_id
}