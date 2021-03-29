module "requester_virtual-network-peering" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/virtual-network-peering?ref=master"

  name                 = var.name
  resource_group       = var.requester_vnet_resource_group_name
  virtual_network_name = var.requester_vnet_name

  remote_resource_group_name  = var.acceptor_vnet_resource_group_name
  remote_virtual_network_name = var.acceptor_vnet_name

  allow_virtual_network_access = var.requester_allow_virtual_network_access
  allow_forwarded_traffic      = var.requester_allow_forwarded_traffic
  allow_gateway_transit        = var.requester_allow_gateway_transit
  use_remote_gateways          = var.requester_use_remote_gateways
}

module "acceptor_virtual-network-peering" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/virtual-network-peering?ref=master"

  name                 = var.name
  resource_group       = var.acceptor_vnet_resource_group_name
  virtual_network_name = var.acceptor_vnet_name

  remote_resource_group_name  = var.requester_vnet_resource_group_name
  remote_virtual_network_name = var.requester_vnet_name

  allow_virtual_network_access = var.acceptor_allow_virtual_network_access
  allow_forwarded_traffic      = var.acceptor_allow_forwarded_traffic
  allow_gateway_transit        = var.acceptor_allow_gateway_transit
  use_remote_gateways          = var.acceptor_use_remote_gateways
}