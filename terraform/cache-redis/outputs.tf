output "id" {
  value = module.redis_cache.id
}

output "hostname" {
  value = module.redis_cache.hostname
}

output "private_hostname" {
  value = var.public_network_access_enabled ? module.redis_cache.hostname : "${local.name}.redis.cache.${data.azurerm_private_dns_zone.private_dns_zone.name}"
}

output "vpn_uri" {
  value = "${var.name}.${var.resource_group}.redis.cache.${var.res_dns_zone}"
}

output "key_vault_secret_name_connection_string" {
  value = azurerm_key_vault_secret.store_redis_connection_string.name
}

output "key_vault_secret_name_private_key" {
  value = azurerm_key_vault_secret.store_redis_primary_access_key.name
}