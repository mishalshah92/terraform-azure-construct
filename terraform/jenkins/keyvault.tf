resource "random_password" "metric_key" {
  length  = 64
  special = false
}

resource "random_password" "jenkins_worker_password" {
  length  = 64
  special = false
}

resource "azurerm_key_vault_secret" "store_metric_key" {
  name         = "${local.keyvault_jenkins_master_secret_name_prefix}-metric-key"
  value        = random_password.metric_key.result
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
  content_type = "string"
  tags         = local.tags
}