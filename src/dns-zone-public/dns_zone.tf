module "dns_zone_public" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/dns-zone-public?ref=master"

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

resource "azurerm_dns_ns_record" "patent_zone_ns_record" {

  count = var.parent_zone == null ? 0 : 1

  name                = trimspace(replace(var.name, ".${var.parent_zone}", ""))
  zone_name           = var.parent_zone
  resource_group_name = var.parent_zone_rg
  ttl                 = 300

  records = module.dns_zone_public.name_servers

  tags = local.tags
}