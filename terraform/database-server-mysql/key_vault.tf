locals {
  keyvault_secret_name = "${var.resource_group}-database-server-mysql-${var.name}"
}

resource "random_password" "mysql_password" {
  length           = 16
  special          = false
  override_special = "!#$%^&*()"
}

resource "azurerm_key_vault_secret" "store_mysql_password" {
  name         = local.keyvault_secret_name
  value        = random_password.mysql_password.result
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}