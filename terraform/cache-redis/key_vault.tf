locals {
  keyvault_secret_name = "${var.resource_group}-cache-redis-${var.name}"
}

resource "azurerm_key_vault_secret" "store_redis_primary_access_key" {
  name         = local.keyvault_secret_name
  value        = module.redis_cache.primary_access_key
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "store_redis_uri" {
  name         = "${local.keyvault_secret_name}-uri"
  value        = module.redis_cache.hostname
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "store_redis_vpn_uri" {
  name         = "${local.keyvault_secret_name}-vpn-uri"
  value        = "${var.name}.${var.resource_group}.redis.cache.${var.res_dns_zone}"
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}

resource "azurerm_key_vault_secret" "store_redis_connection_string" {
  name         = "${local.keyvault_secret_name}-connection-string"
  value        = module.redis_cache.primary_connection_string
  key_vault_id = data.azurerm_key_vault.keyvault.id
  content_type = "string"
  tags         = local.tags
}