output "function_app_name" {
  value = local.function_app_name
}

output "function_app_principal_id" {
  value = module.function_app.identity[0].principal_id
}

output "function_app_tenant_id" {
  value = module.function_app.identity[0].tenant_id
}

output "hostname" {
  value = module.function_app.default_hostname
}

output "key_vault_name" {
  value = local.key_vault_name
}

output "app_service_plan_name" {
  value = local.app_service_plan_name
}

output "storage_account_name" {
  value = local.storage_account_name
}

output "app_insights_name" {
  value = local.app_insights_name
}

output "ad_application_name" {
  value = local.ad_application_name
}