module "gateway_subnet" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/subnet?ref=0.3"

  name                 = "GatewaySubnet"
  resource_group       = var.resource_group
  virtual_network_name = module.vnet.name
  address_prefixes     = var.gateway_subnet_address_spaces

  depends_on = [
    module.vnet
  ]
}