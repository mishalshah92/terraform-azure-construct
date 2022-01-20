module "dns_zone_private" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/dns-zone-private?ref=0.9"

  name = var.name

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
}