data "azurerm_subscription" "current" {}

## Generic Resources

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  name                = var.alert_action_group_name
  resource_group_name = var.hub_rg
}

data "azurerm_key_vault" "rg_keyvault" {
  name                = var.resource_group
  resource_group_name = var.resource_group
}

data "azurerm_container_registry" "container_registry" {
  name                = var.acr_login_server
  resource_group_name = var.hub_rg
}

## VMSS

data "azurerm_image" "app_image" {
  name                = var.vm_image_name
  resource_group_name = var.hub_rg
}

data "azurerm_subnet" "app_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.virtual_network_name
  resource_group_name  = var.resource_group
}

data "azurerm_key_vault" "devops_keyvault" {
  name                = var.devops_key_vault
  resource_group_name = var.devops_rg
}

data "azurerm_ssh_public_key" "ssh_key" {
  name                = "vm_${var.admin_username}"
  resource_group_name = var.hub_rg
}

data "azurerm_key_vault_secret" "db_secret" {
  name         = var.keyvault_grafana_secret_name_prefix
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
}

data "azurerm_key_vault_secret" "devops_keyvault_influxdb_token" {
  name         = var.telegraf_out_influxdb_token_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "azurerm_storage_account" "grafana_storage_account" {
  name                = var.grafana_storage_account
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "devops_keyvault_es_password" {
  name         = var.es_password_keyvault_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

# Azure AD

data "azuread_application" "grafana" {
  display_name = var.grafana_ad_application_name
}

data "template_file" "grafana_service_docker_compose" {
  template = file("${path.module}/configs/grafana.yml")

  vars = {

    acr_login_server = var.acr_login_server

    # Grafana
    grafana_tag                = var.grafana_tag
    grafana_data_path          = local.grafana_data_path
    grafana_port               = var.grafana_service_port
    grafana_server_root_url    = var.grafana_server_root_url
    gf_security_admin_user     = "admin"
    gf_security_admin_password = random_password.password.result

    # Azure
    grafana_azure_managed_identity_client_id = azurerm_user_assigned_identity.grafana_vmss_user_identity.client_id

    # Azure External Storage Account
    gf_external_image_storage_azure_blob_account_name           = var.grafana_storage_account
    gf_external_image_storage_azure_blob_account_key            = data.azurerm_storage_account.grafana_storage_account.primary_access_key
    gf_external_image_storage_azure_blob_account_container_name = local.grafana_data_path

    # Azure Auth
    grafana_auth_azuread_tenant_id     = data.azurerm_subscription.current.tenant_id
    grafana_auth_azuread_client_id     = data.azuread_application.grafana.application_id
    grafana_auth_azuread_client_secret = random_password.grafana_app_client_secret.result
    ## DB Config
    grafana_db_host     = var.grafana_database_host
    grafana_db_name     = var.grafana_database_name
    grafana_db_user     = var.grafana_database_username
    grafana_db_password = data.azurerm_key_vault_secret.db_secret.value

    # Filebeat
    filebeat_tag       = var.filebeat_tag
    es_hosts           = "[${var.es_host}]"
    es_username        = var.es_username
    es_password        = data.azurerm_key_vault_secret.devops_keyvault_es_password.value
    app_customer       = var.customer
    app_owner          = var.owner
    app_email          = var.email
    app_env            = var.env
    app_deployment     = var.deployment
    app_repo           = var.repo
    app_module         = var.module
    app_resource_group = var.resource_group
  }

}
