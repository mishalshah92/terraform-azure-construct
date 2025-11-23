module "dns_zone_private" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/dns-zone-private?ref=0.3"

  name = "${local.resource_group_name}.${var.private_zone_postfix}"

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
    module.resource-group
  ]
}