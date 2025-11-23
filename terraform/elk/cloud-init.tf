module "elasticsearch_kibana_cloud_init" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/cloud-init-microservice-fileshare-elk?ref=0.3"

  resource_group_name    = var.resource_group
  docker_compose_content = data.template_file.elasticsearch_service_docker_compose.rendered

  # Azure Login
  azure_identity_login          = true
  azure_user_identity_object_id = azurerm_user_assigned_identity.elasticsearch_kibana_vmss_user_identity.id
  acr_login                     = false

  # Docker login
  docker_login = true
  login_server = "${var.acr_login_server}.azurecr.io"
  username     = data.azurerm_container_registry.container_registry.admin_username
  password     = data.azurerm_container_registry.container_registry.admin_password

  # ELK Settings
  elk_settings  = true
  elk_data_path = local.elk_data_path

  # FileShare Settings
  file_share_settings             = true
  file_share_name                 = data.azurerm_storage_share.elk_file_share.name
  file_share_mount_path           = local.elk_data_path
  file_share_storage_account_name = var.elasticsearch_storage_account
  file_share_gid                  = 0
  file_share_uid                  = 1000

  # Telegraf
  enable_telegraf              = true
  telegraf_out_influxdb_host   = var.telegraf_out_influxdb_host
  telegraf_out_influxdb_token  = data.azurerm_key_vault_secret.devops_keyvault_influxdb_token.value
  telegraf_out_influxdb_org    = var.telegraf_out_influxdb_org
  telegraf_out_influxdb_bucket = var.telegraf_out_influxdb_bucket

  # Tags
  tags = local.tags
}