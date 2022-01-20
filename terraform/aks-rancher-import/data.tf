data "azurerm_key_vault" "keyvault" {
  name                = var.resource_group
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "rancher_api_url" {
  name         = "rancher-${var.rancher_server}-api-url"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "rancher_access_key" {
  name         = "rancher-${var.rancher_server}-access-key"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}

data "azurerm_key_vault_secret" "rancher_secret_key" {
  name         = "rancher-${var.rancher_server}-secret-key"
  key_vault_id = data.azurerm_key_vault.keyvault.id
}