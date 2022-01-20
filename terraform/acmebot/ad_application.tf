resource "azuread_application" "active_directory_app" {
  name     = local.ad_application_name
  homepage = "https://${local.function_app_name}.azurewebsites.net"

  identifier_uris = [
    "https://${local.function_app_name}.azurewebsites.net"
  ]

  reply_urls = [
    "https://${local.function_app_name}.azurewebsites.net/.auth/login/aad/callback"
  ]
  public_client              = false
  available_to_other_tenants = false
  oauth2_allow_implicit_flow = true
  type                       = "webapp/api"
  owners                     = data.azuread_users.keyvault_admins.object_ids
  prevent_duplicate_names    = true

  //  required_resource_access {
  //    resource_app_id = data.azuread_service_principal.active_directory.application_id
  //    resource_access {
  //      id = "311a71cc-e848-46a1-bdf8-97ff7156d8e6" # User.Read
  //      type = "Scope"
  //    }
  //  }

  required_resource_access {
    resource_app_id = data.azuread_service_principal.microsoft_graph.application_id
    resource_access {
      id   = "e1fe6dd8-ba31-4d61-89e7-88639da4683d" # User.Read
      type = "Scope"
    }
  }

}

resource "azuread_application_password" "active_directory_app_client_secret" {
  application_object_id = azuread_application.active_directory_app.id
  value                 = random_password.password.result
  end_date_relative     = "8760h"
}

resource "random_password" "password" {
  length  = 32
  special = true
}