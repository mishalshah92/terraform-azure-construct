locals {
  keyvault_secret_name = "${var.resource_group}-cosmosdb-mongodb-${var.name}"
}

resource "azurerm_key_vault_secret" "store_db_password" {
  name         = local.keyvault_secret_name
  value        = module.cosmosdb_account.primary_master_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "store_db_connection_string" {
  name         = "${local.keyvault_secret_name}-connection-string"
  value        = module.cosmosdb_account.connection_strings[0]
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}