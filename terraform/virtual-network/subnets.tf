module "subnet" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/subnet-nsg?ref=3.3"

  for_each = var.subnet_address_spaces

  name                                           = each.key
  location                                       = var.location
  virtual_network_name                           = module.vnet.name
  address_prefixes                               = each.value.address_prefixes
  service_endpoints                              = lookup(each.value, "service_endpoints", [])
  enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", false)
  enforce_private_link_service_network_policies  = lookup(each.value, "enforce_private_link_service_network_policies", false)

  # NSG
  nsg_name  = each.value.nsg_name
  nsg_rules = var.nsg_rules[each.value.nsg_name]

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

  depends_on = [
    module.vnet
  ]
}