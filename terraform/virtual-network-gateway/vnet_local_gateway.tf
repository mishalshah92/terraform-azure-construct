//resource "azurerm_local_network_gateway" "local_net_gateway" {
//  name                = var.name
//  resource_group_name = var.resource_group
//  location            = var.location
//  gateway_address     = module.vnet_gateway.ip_address
//  address_space       = concat(var.pts_address_spaces, data.azurerm_virtual_network.vnet.address_space)
//
//  tags = local.tags
//}