module "dns_zone_private" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform//dns-zone-private?ref=0.3"

  name           = "${var.resource_group}.${var.private_zone_postfix}"
  resource_group = var.resource_group
  tags           = module.tags.tags
}