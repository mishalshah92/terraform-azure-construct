resource "azurerm_dns_a_record" "tools_dns_zone_record" {
  name                = "${var.name}.aks.${var.location}.${var.resource_group}"
  zone_name           = var.dns_zone
  resource_group_name = var.hub_rg
  ttl                 = 300
  records = [
    data.azurerm_network_interface.kuberentes_network_interface.private_ip_address
  ]

  tags = local.tags
}