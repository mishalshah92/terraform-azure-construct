resource "azurerm_private_dns_zone" "aks_private_dns_zone" {
  name                = "${var.resource_group}.privatelink.${var.location}.azmk8s.io"
  resource_group_name = var.resource_group

  tags = local.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_private_dns_zone_vnet_link" {

  for_each = data.azurerm_virtual_network.vnet

  name                  = each.key
  resource_group_name   = azurerm_private_dns_zone.aks_private_dns_zone.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.aks_private_dns_zone.name
  virtual_network_id    = each.value.id

  tags = local.tags
}