module "nsg_rules" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/network-security-group-rules?ref=2.8"

  for_each = var.nsg_rules

  location                    = var.location
  network_security_group_name = each.key
  nat_gateway_rules           = each.value

  # Tags
  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}

//resource "azurerm_network_security_rule" "requester_deny_nsg_rule" {
//
//  count = length(var.requester_net_sg_name)
//
//  name                        = "deny-peering-${var.acceptor_vnet_name}-traffic"
//  priority                    = "2090"
//  direction                   = "Inbound"
//  access                      = "Deny"
//  protocol                    = "*"
//  source_port_range           = "*"
//  destination_port_range      = "*"
//  source_address_prefix       = data.azurerm_virtual_network.acceptor_vnet.address_space[0]
//  destination_address_prefix  = "VirtualNetwork"
//  network_security_group_name = var.requester_net_sg_name[count.index]
//  description                 = "Deny traffic from Peering Vnet ${var.acceptor_vnet_name}"
//  resource_group_name         = var.requester_vnet_resource_group_name
//
//  lifecycle {
//    create_before_destroy = false
//  }
//
//}

//resource "azurerm_network_security_rule" "acceptor_deny_nsg_rule" {
//
//  count = length(var.acceptor_net_sg_name)
//
//  name                        = "deny-peering-${var.requester_vnet_name}-traffic"
//  priority                    = "2090"
//  direction                   = "Inbound"
//  access                      = "Deny"
//  protocol                    = "*"
//  source_port_range           = "*"
//  destination_port_range      = "*"
//  source_address_prefix       = data.azurerm_virtual_network.requster_vnet.address_space[0]
//  destination_address_prefix  = "VirtualNetwork"
//  network_security_group_name = var.acceptor_net_sg_name[count.index]
//  description                 = "Deny traffic from Peering Vnet ${var.requester_vnet_name}"
//  resource_group_name         = var.acceptor_vnet_resource_group_name
//
//  lifecycle {
//    create_before_destroy = false
//  }
//
//}