output "application_id" {
  value = azuread_application.ad_application.application_id
}

output "sp_id" {
  value = azuread_service_principal.ad_sp.id
}