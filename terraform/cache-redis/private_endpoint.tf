resource "azurerm_private_endpoint" "postgres_private_endpoint" {

  count = var.public_network_access_enabled ? 0 : 1

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = data.azurerm_subnet.redis_subnet.id

  private_service_connection {
    name                           = local.name
    private_connection_resource_id = module.redis_cache.id
    is_manual_connection           = false
    subresource_names = [
      "redisCache"
    ]
  }

  private_dns_zone_group {
    name = local.name
    private_dns_zone_ids = [
      data.azurerm_private_dns_zone.private_dns_zone.id
    ]
  }

  tags = local.tags
}

resource "azurerm_private_dns_a_record" "private_dns_db_record" {

  count = var.public_network_access_enabled ? 0 : 1

  name                = "${local.name}.redis.cache"
  zone_name           = data.azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = data.azurerm_private_dns_zone.private_dns_zone.resource_group_name
  ttl                 = 10
  records = [
    azurerm_private_endpoint.postgres_private_endpoint[count.index].private_service_connection[0].private_ip_address
  ]

  tags = local.tags
}

resource "azurerm_dns_a_record" "res_dns_record" {

  count = var.public_network_access_enabled ? 0 : 1

  name                = "${var.name}.${var.resource_group}.redis.cache"
  zone_name           = var.res_dns_zone
  resource_group_name = var.hub_rg
  ttl                 = 300
  records = [
    azurerm_private_endpoint.postgres_private_endpoint[count.index].private_service_connection[0].private_ip_address
  ]

  tags = local.tags
}
