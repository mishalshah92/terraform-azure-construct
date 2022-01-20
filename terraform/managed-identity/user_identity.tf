resource "azurerm_user_assigned_identity" "user_identity" {
  name                = "${var.module}-${var.resource_group}-${var.deployment}"
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "user_identity_role_assignment_reader" {

  for_each = data.azurerm_resource_group.rg

  scope                = each.value.id
  role_definition_name = "Reader"
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id
}

resource "azurerm_role_assignment" "user_identity_role_assignment_acr_pull" {

  for_each = data.azurerm_container_registry.container_registry

  scope                = each.value.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id
}

resource "azurerm_role_assignment" "user_identity_role_assignment_dnszone_contributor" {

  for_each = data.azurerm_dns_zone.dnszone

  scope                = each.value.id
  role_definition_name = "DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.user_identity.principal_id
}