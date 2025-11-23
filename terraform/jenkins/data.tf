data "azurerm_subscription" "current" {}

## Data source is having issue, check: https://github.com/terraform-providers/terraform-provider-azurerm/issues/10503

data "azurerm_application_gateway" "service_app_gateway" {
  name                = var.app_gateway_name
  resource_group_name = var.resource_group
}

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

data "azuread_users" "owners" {
  user_principal_names = var.jenkins_master_admin_email
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

data "azurerm_key_vault_secret" "devops_keyvault_es_password" {
  name         = var.es_password_keyvault_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "azurerm_ssh_public_key" "ssh_key" {
  name                = "vm_${var.admin_username}"
  resource_group_name = var.hub_rg
}

data "azuread_application" "jenkins_master" {
  display_name = var.jenkins_master_ad_application_name
}

data "azurerm_image" "jenkins_worker_image" {
  name                = var.jenkins_worker_vm_image_name
  resource_group_name = var.hub_rg
}

data "azurerm_storage_account" "jenkins_storage_account" {
  name                = var.jenkins_storage_account
  resource_group_name = var.resource_group
}

data "azurerm_key_vault_secret" "devops_keyvault_influxdb_token" {
  name         = var.telegraf_out_influxdb_token_secret_name
  key_vault_id = data.azurerm_key_vault.devops_keyvault.id
}

data "template_file" "jenkins_master_service_docker_compose" {
  template = file("${path.module}/configs/jenkins-master.yml")

  vars = {

    acr_login_server = var.acr_login_server

    # Jenkins
    tag                     = var.jenkins_master_service_tag
    port                    = var.jenkins_master_service_port
    jenkins_data_path       = local.jenkins_data_path
    jenkins_local_data_path = local.jenkins_local_data_path

    # Basic
    jenkins_master_url             = "https://${var.hostname}"
    jenkins_master_admin_email     = var.email
    jenkins_master_storage_account = data.azurerm_storage_account.jenkins_storage_account.name
    jenkins_executors              = 0

    # Jira Site
    jira_site_url           = var.jira_site_url
    jira_site_client_id     = var.jira_site_client_id
    jira_site_credential_id = "https://${var.resource_group}.vault.azure.net/secrets/${var.jira_site_credential_keyvault_id}"

    # Credentials
    jenkins_master_metrics_key                   = random_password.metric_key.result
    jenkins_master_default_azure_subscription_id = data.azurerm_subscription.current.subscription_id
    jenkins_master_key_vault_url                 = data.azurerm_key_vault.rg_keyvault.vault_uri
    jenkins_worker_username                      = "ubuntu"
    jenkins_worker_password                      = random_password.jenkins_worker_password.result
    jenkins_git_username                         = var.jenkins_git_username
    jenkins_git_private_key_path                 = "/var/jenkins_data/credentials/ssh_username_with_private_key/${var.jenkins_git_username}/${var.jenkins_git_username}.pem"

    # Authentication - Azure AD
    jenkins_master_azure_directory_tenant_id         = data.azurerm_subscription.current.tenant_id
    jenkins_master_azure_directory_app_client_id     = data.azuread_application.jenkins_master.application_id
    jenkins_master_azure_directory_app_client_secret = azuread_application_password.ad_app_password.value

    # Authorization - Azure AD
    jenkins_master_azure_ad_group_read      = "${azuread_group.jenkins-read.display_name} (${azuread_group.jenkins-read.object_id})"
    jenkins_master_azure_ad_group_executor  = "${azuread_group.jenkins-executor.display_name} (${azuread_group.jenkins-executor.object_id})"
    jenkins_master_azure_ad_group_developer = "${azuread_group.jenkins-developer.display_name} (${azuread_group.jenkins-developer.object_id})"
    jenkins_master_azure_ad_group_admin     = "${azuread_group.jenkins-admin.display_name} (${azuread_group.jenkins-admin.object_id})"

    # Worker
    jenkins_worker_cloud_name = replace(lower(replace("${data.azurerm_subscription.current.display_name}-${var.resource_group}-${var.deployment}", " ", "-")), "microsoft", "ms")
    jenkins_worker_max        = var.jenkins_worker_max

    # Worker - Default
    jenkins_worker_default_vm_image_id     = data.azurerm_image.jenkins_worker_image.id
    jenkins_worker_default_location        = var.jenkins_worker_default_location
    jenkins_worker_default_USMI            = azurerm_user_assigned_identity.jenkins_worker_user_identity.id
    jenkins_worker_default_vm_size         = var.jenkins_worker_default_vm_size
    jenkins_worker_default_vm_disk_size    = var.jenkins_worker_default_vm_disk_size
    jenkins_worker_default_vnet_rg         = var.resource_group
    jenkins_worker_default_vnet_name       = var.virtual_network_name
    jenkins_worker_default_subnet_name     = var.subnet_name
    jenkins_worker_default_subnet_nsg_name = "${var.subnet_name}-nsg"
    jenkins_worker_default_no_executors    = 1

    # Worker - Medium
    jenkins_worker_medium_vm_image_id     = data.azurerm_image.jenkins_worker_image.id
    jenkins_worker_medium_location        = var.jenkins_worker_medium_location
    jenkins_worker_medium_USMI            = azurerm_user_assigned_identity.jenkins_worker_user_identity.id
    jenkins_worker_medium_vm_size         = var.jenkins_worker_medium_vm_size
    jenkins_worker_medium_vm_disk_size    = var.jenkins_worker_medium_vm_disk_size
    jenkins_worker_medium_vnet_rg         = var.resource_group
    jenkins_worker_medium_vnet_name       = var.virtual_network_name
    jenkins_worker_medium_subnet_name     = var.subnet_name
    jenkins_worker_medium_subnet_nsg_name = "${var.subnet_name}-nsg"
    jenkins_worker_medium_no_executors    = 1

    # Worker - Large
    jenkins_worker_large_vm_image_id     = data.azurerm_image.jenkins_worker_image.id
    jenkins_worker_large_location        = var.jenkins_worker_large_location
    jenkins_worker_large_USMI            = azurerm_user_assigned_identity.jenkins_worker_user_identity.id
    jenkins_worker_large_vm_size         = var.jenkins_worker_large_vm_size
    jenkins_worker_large_vm_disk_size    = var.jenkins_worker_large_vm_disk_size
    jenkins_worker_large_vnet_rg         = var.resource_group
    jenkins_worker_large_vnet_name       = var.virtual_network_name
    jenkins_worker_large_subnet_name     = var.subnet_name
    jenkins_worker_large_subnet_nsg_name = "${var.subnet_name}-nsg"
    jenkins_worker_large_no_executors    = 1

    # Tags
    customer          = var.customer
    env               = var.env
    deployment        = var.deployment
    resource_group    = var.resource_group
    owner             = var.owner
    email             = var.email
    repo              = var.repo
    module            = var.module
    vanta_non_prod    = lookup(var.tags, "VantaNonProd")
    vanta_description = "Jenkins dynamic worker for one build use."

    # FileBeat
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