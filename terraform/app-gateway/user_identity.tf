# AppGateway - User Managed Identity

resource "azurerm_user_assigned_identity" "app_gateway_user_identity" {
  name                = local.name
  resource_group_name = var.resource_group
  location            = var.location
  tags                = local.tags
}

resource "azurerm_role_assignment" "app_gateway_user_identity" {

  for_each = toset(var.user_identity_permissions)

  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.app_gateway_user_identity.principal_id
}