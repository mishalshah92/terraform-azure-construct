module "vnet" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/virtual-network?ref=0.1"

  name           = var.name
  location       = var.location
  address_spaces = var.address_spaces
  enable_ddos    = var.enable_ddos

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