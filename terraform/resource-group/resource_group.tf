module "resource-group" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/resource-group?ref=3.0"

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