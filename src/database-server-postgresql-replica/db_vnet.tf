resource "azurerm_private_endpoint" "postgres_private_endpoint" {

  count = var.enable_private_link ? 1 : 0

  name                = local.name
  location            = var.location
  resource_group_name = var.resource_group
  subnet_id           = data.azurerm_subnet.db_subnet.id

  private_service_connection {
    name                           = local.name
    private_connection_resource_id = module.postgresql-db-replica.id
    is_manual_connection           = false
    subresource_names = [
      "postgresqlServer"
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

  count = var.enable_private_link ? 1 : 0

  name                = "${var.name}.postgres.database"
  zone_name           = data.azurerm_private_dns_zone.private_dns_zone.name
  resource_group_name = data.azurerm_private_dns_zone.private_dns_zone.resource_group_name
  ttl                 = 10
  records = [
    azurerm_private_endpoint.postgres_private_endpoint[count.index].private_service_connection[0].private_ip_address
  ]

  tags = local.tags
}


## If you want to add Vnet rule Make sure you enable public traffic flag to put this config. Afterwords you can disable it.
resource "azurerm_postgresql_virtual_network_rule" "db_vnet_association" {

  for_each = substr(var.sku_name, 0, 1) == "B" ? {} : data.azurerm_subnet.allowed_subnet

  name                                 = each.key
  resource_group_name                  = var.resource_group
  server_name                          = local.name
  subnet_id                            = each.value.id
  ignore_missing_vnet_service_endpoint = true

  depends_on = [
    module.postgresql-db-replica
  ]
}



