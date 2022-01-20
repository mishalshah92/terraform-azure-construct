locals {
  nsg_rules = flatten([
    for nsg, rules in var.nsg_rules : [
      for rule in rules : {
        name                        = rule.name
        description                 = lookup(rule, "description", null)
        priority                    = rule.priority
        direction                   = rule.direction
        access                      = rule.access
        protocol                    = rule.protocol
        source_port_range           = rule.source_port_range
        destination_port_range      = rule.destination_port_range
        source_address_prefix       = rule.source_address_prefix
        destination_address_prefix  = rule.destination_address_prefix
        network_security_group_name = nsg
      }
    ]
  ])
}

module "network-security-group" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/network-security-group?ref=0.3"

  count = length(var.subnet_address_spaces)

  name     = "${lookup(element(var.subnet_address_spaces, count.index), "name")}-nsg"
  location = var.location

  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  git_commit     = var.git_commit
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_association" {

  count = length(module.network-security-group)

  subnet_id                 = module.subnet[count.index].id
  network_security_group_id = module.network-security-group[count.index].id

  depends_on = [
    module.subnet,
    module.network-security-group
  ]
}

resource "azurerm_network_security_rule" "nsg_rules" {

  count = length(local.nsg_rules)

  name                        = local.nsg_rules[count.index].name
  priority                    = local.nsg_rules[count.index].priority
  direction                   = local.nsg_rules[count.index].direction
  access                      = local.nsg_rules[count.index].access
  protocol                    = local.nsg_rules[count.index].protocol
  source_port_range           = local.nsg_rules[count.index].source_port_range
  destination_port_range      = local.nsg_rules[count.index].destination_port_range
  source_address_prefix       = local.nsg_rules[count.index].source_address_prefix
  destination_address_prefix  = local.nsg_rules[count.index].destination_address_prefix
  network_security_group_name = local.nsg_rules[count.index].network_security_group_name
  description                 = local.nsg_rules[count.index].description
  resource_group_name         = var.resource_group

  lifecycle {
    create_before_destroy = false
  }

  depends_on = [
    module.network-security-group
  ]

}