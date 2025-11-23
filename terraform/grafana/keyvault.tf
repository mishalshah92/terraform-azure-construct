resource "random_password" "password" {
  length  = 16
  special = false
}

resource "azurerm_key_vault_secret" "store_grafana_admin_password" {
  name         = "${local.name}-admin-password"
  value        = random_password.password.result
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
  content_type = "string"
  tags         = local.tags
}