resource "azurerm_role_assignment" "dns_zone_permissions" {

  for_each = data.azurerm_dns_zone.dns_zones

  role_definition_name = "DNS Zone Contributor"
  scope                = each.value.id
  principal_id         = module.function_app.identity.0.principal_id
}