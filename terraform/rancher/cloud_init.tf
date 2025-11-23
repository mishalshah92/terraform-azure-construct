module "cloud_init" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/cloud-init-microservice-datadisk?ref=3.1"

  docker_compose_content = data.template_file.rancher_service_docker_compose.rendered

  # Azure Login
  azure_identity_login          = true
  azure_user_identity_object_id = azurerm_user_assigned_identity.rancher_vm_user_identity.id
  acr_login                     = false

  # Docker login
  docker_login = true
  login_server = "${var.acr_login_server}.azurecr.io"
  username     = data.azurerm_container_registry.container_registry.admin_username
  password     = data.azurerm_container_registry.container_registry.admin_password

  #Mount Options
  mount_disk = var.rancher_volume_disk
  mount_path = var.rancher_data_path

  # Telegraf
  enable_telegraf              = true
  telegraf_out_influxdb_host   = var.telegraf_out_influxdb_host
  telegraf_out_influxdb_token  = data.azurerm_key_vault_secret.devops_keyvault_influxdb_token.value
  telegraf_out_influxdb_org    = var.telegraf_out_influxdb_org
  telegraf_out_influxdb_bucket = var.telegraf_out_influxdb_bucket

  # Tags
  tags = local.tags
}