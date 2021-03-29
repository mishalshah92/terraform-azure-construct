data "azurerm_virtual_network" "acceptor_vnet" {
  resource_group_name = var.acceptor_vnet_resource_group_name
  name                = var.acceptor_vnet_name
}

data "azurerm_virtual_network" "requster_vnet" {
  resource_group_name = var.requester_vnet_resource_group_name
  name                = var.requester_vnet_name
}