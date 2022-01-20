resource "azurerm_role_assignment" "user_identity_role_assignment_reader" {

  for_each = data.azurerm_resource_group.rg

  scope                = each.value.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.ad_sp.object_id
}

resource "azurerm_role_assignment" "user_identity_role_assignment_acr_pull" {

  for_each = data.azurerm_container_registry.container_registry

  scope                = each.value.id
  role_definition_name = "AcrPull"
  principal_id         = azuread_service_principal.ad_sp.object_id
}

resource "azurerm_role_assignment" "user_identity_role_assignment_dnszone_contributor" {

  for_each = data.azurerm_dns_zone.dnszone

  scope                = each.value.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azuread_service_principal.ad_sp.object_id
}

resource "azurerm_role_assignment" "user_identity_role_assignment_private_dnszone_contributor" {

  for_each = data.azurerm_private_dns_zone.private_dnszone

  scope                = each.value.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azuread_service_principal.ad_sp.object_id
}