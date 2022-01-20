resource "azurerm_dns_a_record" "private_service_dns_record" {

  for_each = var.private_dns

  name                = each.key
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = 300
  records             = [var.private_ip]

  tags = local.tags
}

resource "azurerm_dns_cname_record" "public_service_dns_record" {

  for_each = var.public_dns

  name                = each.key
  zone_name           = each.value.zone_name
  resource_group_name = each.value.resource_group_name
  ttl                 = 300
  record              = azurerm_public_ip.app_gateway_public_ip.fqdn

  tags = local.tags
}