module "dns_zone_private" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src//dns-zone-private?ref=add-tag-module"

  name           = "${var.resource_group}.${var.private_zone_postfix}"
  resource_group = var.resource_group
  tags           = module.tags.tags
}