resource "random_password" "elasticsearch_password" {
  length           = 16
  special          = false
  override_special = "!#$%^&*()"
}

resource "azurerm_key_vault_secret" "store_elasticsearch_password" {
  name         = local.keyvault_elastic_secret_name
  value        = random_password.elasticsearch_password.result
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
  content_type = "string"
  tags         = local.tags
}