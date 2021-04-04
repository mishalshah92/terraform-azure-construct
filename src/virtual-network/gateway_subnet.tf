locals {
  gateway_subnet_name    = "GatewaySubnet"
  gateway_subnet_rt_name = "${var.resource_group}_${local.gateway_subnet_name}-rt"
}

module "gateway_subnet" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/subnet?ref=0.1"

  name                 = local.gateway_subnet_name
  resource_group       = var.resource_group
  virtual_network_name = module.vnet.name
  address_prefixes     = var.gateway_subnet_address_spaces

  depends_on = [
    module.vnet
  ]
}

module "gateway_subnet_route_table" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/route-table?ref=0.1"

  name     = local.gateway_subnet_rt_name
  location = var.location

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

resource "azurerm_subnet_route_table_association" "gateway_subnet_rt_association" {
  subnet_id      = module.gateway_subnet.id
  route_table_id = module.gateway_subnet_route_table.id
}