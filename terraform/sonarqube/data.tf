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
  name         = var.keyvault_sonarqube_secret_name_prefix
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
}

data "azurerm_key_vault_secret" "devops_keyvault_influxdb_token" {
  name         = var.telegraf_out_influxdb_token_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "azurerm_storage_account" "sonarqube_storage_account" {
  name                = var.sonarqube_storage_account
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "devops_keyvault_es_password" {
  name         = var.es_password_keyvault_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "template_file" "sonarqube_service_docker_compose" {
  template = file("${path.module}/configs/sonarqube.yml")

  vars = {

    acr_login_server    = var.acr_login_server
    sonarqube_tag       = var.sonarqube_tag
    sonarqube_data_path = local.sonarqube_data_path
    sonarqube_port      = var.sonarqube_service_port

    # DB Config
    db_username = var.sonarqube_database_username
    db_password = data.azurerm_key_vault_secret.db_secret.value
    db_host     = var.sonarqube_database_host
    db_name     = var.sonarqube_database_name
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
