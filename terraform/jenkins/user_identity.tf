# VMSS - User Managed Identity - Jenkins Master

resource "azurerm_user_assigned_identity" "jenkins_master_vmss_user_identity" {
  name                = "${local.name}-vmss-jenkins-master"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "jenkins_master_vmss_user_identity_acr_reader" {
  scope                = data.azurerm_container_registry.container_registry.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.jenkins_master_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_master_vmss_user_identity_key_vault_secrets_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.jenkins_master_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_master_vmss_user_identity_storage_account_contributor" {
  scope                = data.azurerm_storage_account.jenkins_storage_account.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.jenkins_master_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_master_vmss_user_identity_subscription_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.jenkins_master_vmss_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_master_vmss_user_identity_key_vault_administrator" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.jenkins_master_vmss_user_identity.principal_id
}

# User Managed Identity - Jenkins Worker

resource "azurerm_user_assigned_identity" "jenkins_worker_user_identity" {
  name                = "${local.name}-vmss-jenkins-worker"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "jenkins_worker_user_identity_subscription_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.jenkins_worker_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_worker_vmss_user_identity_key_vault_administrator" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_user_assigned_identity.jenkins_worker_user_identity.principal_id
}

resource "azurerm_role_assignment" "jenkins_worker_vmss_user_identity_storage_account_contributor" {
  scope                = data.azurerm_subscription.current.id
  role_definition_name = "Storage Account Contributor"
  principal_id         = azurerm_user_assigned_identity.jenkins_worker_user_identity.principal_id
}