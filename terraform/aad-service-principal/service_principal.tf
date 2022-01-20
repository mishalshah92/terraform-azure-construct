locals {
  owners = data.azuread_users.owner_users.object_ids
}

resource "azuread_application" "ad_application" {
  display_name = var.name
  owners       = local.owners
}

resource "azuread_service_principal" "ad_sp" {

  application_id               = azuread_application.ad_application.application_id
  app_role_assignment_required = false
  owners                       = local.owners
  account_enabled              = true
}