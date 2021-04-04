module "function_app" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/function-app?ref=0.1"

  name             = local.function_app_name
  location         = var.location
  function_version = "~3"

  app_service_plan_id     = module.app_service_plan.id
  enabled                 = true
  enable_builtin_logging  = false
  https_only              = true
  client_affinity_enabled = false

  app_settings = {
    "APPLICATIONINSIGHTS_CONNECTION_STRING" = module.application_insights.connection_string
    "FUNCTIONS_WORKER_RUNTIME"              = "dotnet"
    "WEBSITE_RUN_FROM_PACKAGE"              = "https://shibayan.blob.core.windows.net/azure-keyvault-letsencrypt/v3/latest.zip"
    "Acmebot:AzureDns:SubscriptionId"       = data.azurerm_client_config.current.subscription_id
    "Acmebot:Contacts"                      = var.verification_email
    "Acmebot:Endpoint"                      = "https://acme-v02.api.letsencrypt.org/"
    "Acmebot:VaultBaseUrl"                  = module.key_vault.vault_uri
    "Acmebot:Environment"                   = "AzureCloud"
    "Acmebot:Webhook"                       = var.webhook_url
  }

  identity_type = "SystemAssigned"
  ftps_state    = "Disabled"

  auth_settings_enabled = true
  default_provider      = "AzureActiveDirectory"
  issuer                = "https://login.microsoftonline.com/${data.azurerm_client_config.current.tenant_id}/v2.0"
  active_directory_settings = [
    {
      client_id     = azuread_application.active_directory_app.application_id
      client_secret = random_password.password.result
    }
  ]

  //  auth_settings_enabled = false

  # Storage Account
  storage_account_name       = module.storage_account.name
  storage_account_access_key = module.storage_account.primary_access_key

  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  git_commit     = var.git_commit
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}