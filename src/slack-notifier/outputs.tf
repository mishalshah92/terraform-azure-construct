output "logic_app_id" {
  value = module.logic_app.logic_app_id
}

output "logic_app_access_endpoint" {
  value = module.logic_app.logic_app_access_endpoint
}

output "logic_app_integration_account_id" {
  value = module.logic_app.logic_app_integration_account_id
}

output "javascript_code" {
  value = data.template_file.javascript_code.rendered
}