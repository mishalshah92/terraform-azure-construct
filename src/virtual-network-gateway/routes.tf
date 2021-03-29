resource "azurerm_route" "vng_routes" {

  for_each = toset(var.route_tables)

  name                = "allow-${var.name}"
  resource_group_name = var.resource_group
  route_table_name    = each.key
  address_prefix      = var.pts_address_spaces[0]
  next_hop_type       = "VirtualNetworkGateway"

  depends_on = [
    module.vnet_gateway
  ]
}