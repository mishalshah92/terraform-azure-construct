locals {

  routes = flatten([
    for rt_table, rt_datas in var.routes : [
      for routes in rt_datas : {
        name           = routes["name"]
        address_prefix = routes["address_prefix"]
        next_hop_type  = routes["next_hop_type"]
        route_table    = rt_table
      }
    ]
  ])

}

module "route-table" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/route-table?ref=0.1"

  count = length(var.subnet_address_spaces)

  name     = "${lookup(element(var.subnet_address_spaces, count.index), "name")}-rt"
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

resource "azurerm_subnet_route_table_association" "subnet_rt_association" {

  count = length(module.subnet)

  subnet_id      = module.subnet[count.index].id
  route_table_id = module.route-table[count.index].id

  depends_on = [
    module.subnet,
    module.route-table
  ]
}

resource "azurerm_route" "routes" {

  count = length(local.routes)

  name                = lookup(element(local.routes, count.index), "name")
  resource_group_name = var.resource_group
  route_table_name    = lookup(element(local.routes, count.index), "route_table")
  address_prefix      = lookup(element(local.routes, count.index), "address_prefix")
  next_hop_type       = lookup(element(local.routes, count.index), "next_hop_type")

  lifecycle {
    create_before_destroy = false
  }

  depends_on = [
    module.route-table
  ]
}