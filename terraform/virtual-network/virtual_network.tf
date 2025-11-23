module "vnet" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/virtual-network?ref=3.3"

  name           = var.name
  location       = var.location
  address_spaces = var.address_spaces
  enable_ddos    = var.enable_ddos

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