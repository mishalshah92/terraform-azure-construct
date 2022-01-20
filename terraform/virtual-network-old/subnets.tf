module "subnet" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/subnet?ref=0.3"

  count = length(var.subnet_address_spaces)

  name                                           = lookup(element(var.subnet_address_spaces, count.index), "name")
  resource_group                                 = var.resource_group
  virtual_network_name                           = module.vnet.name
  address_prefixes                               = lookup(element(var.subnet_address_spaces, count.index), "address_prefixes")
  service_endpoints                              = lookup(element(var.subnet_address_spaces, count.index), "service_endpoints")
  enforce_private_link_endpoint_network_policies = lookup(element(var.subnet_address_spaces, count.index), "enforce_private_link_endpoint_network_policies")

  depends_on = [
    module.vnet
  ]
}