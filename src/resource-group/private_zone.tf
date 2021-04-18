module "dns_zone_private" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src//dns-zone-private?ref=add-tag-module"

  name           = "${var.name}.${var.private_zone_postfix}"
  resource_group = var.name

  tags = module.default.tags

  depends_on = [
    module.resource-group
  ]
}