data "azurerm_subscription" "current" {}

## Data source is having issue, check: https://github.com/terraform-providers/terraform-provider-azurerm/issues/10503

//data "azurerm_application_gateway" "service_app_gateway" {
//  name                = var.app_gateway_name
//  resource_group_name = var.resource_group
//}

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

data "azurerm_key_vault_secret" "devops_keyvault_influxdb_token" {
  name         = var.telegraf_out_influxdb_token_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

## Matomo

data "azurerm_key_vault_secret" "db_secret" {
  name         = var.keyvault_matomo_secret_name_prefix
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
}

data "azurerm_storage_account" "matomo_storage_account" {
  name                = var.matomo_storage_account
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "devops_keyvault_es_password" {
  name         = var.es_password_keyvault_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "template_file" "matomo_service_docker_compose" {
  template = file("${path.module}/configs/matomo.yml")

  vars = {

    acr_login_server = var.acr_login_server
    matomo_tag       = var.matomo_tag
    matomo_data_path = local.matomo_data_path
    matomo_port      = var.matomo_service_port
    matomo_host      = var.matomo_host

    # DB Config
    db_host     = var.matomo_database_host
    db_username = var.matomo_database_username
    db_password = data.azurerm_key_vault_secret.db_secret.value
    db_dbname   = var.matomo_database_dbname

    #Filebeat
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


