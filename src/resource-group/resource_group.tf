module "resource-group" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/resource-group?ref=master"

  name     = local.resource_group_name
  location = var.location

  customer   = var.customer
  env        = var.env
  owner      = var.owner
  email      = var.email
  repo       = var.repo
  tags       = var.tags
  deployment = var.deployment
  module     = var.module
}