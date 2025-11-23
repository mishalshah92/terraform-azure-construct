locals {
  gateway_subnet_name    = "GatewaySubnet"
  gateway_subnet_rt_name = "${var.resource_group}_${local.gateway_subnet_name}-rt"
}

module "gateway_subnet" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/subnet?ref=3.3"

  name                 = local.gateway_subnet_name
  resource_group       = var.resource_group
  virtual_network_name = module.vnet.name
  address_prefixes     = var.gateway_subnet_address_spaces

  depends_on = [
    module.vnet
  ]
}