resource "azurerm_private_dns_zone_virtual_network_link" "link_private_zone" {

  count = var.resource_group == null ? 0 : 1

  name                  = "${var.resource_group}_${module.vnet.name}"
  private_dns_zone_name = "${var.resource_group}.${var.private_dns_zone_name_postfix}"
  resource_group_name   = var.resource_group
  virtual_network_id    = module.vnet.id
  registration_enabled  = true

  depends_on = [
    module.vnet
  ]
}