locals {
  keyvault_secret_name = "${var.resource_group}-database-server-postgresql-${var.name}"
}

resource "random_password" "postgres_password" {
  length           = 16
  special          = false
  override_special = "!#$%^&*()"
}

resource "azurerm_key_vault_secret" "store_postgres_password" {
  name         = local.keyvault_secret_name
  value        = random_password.postgres_password.result
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}