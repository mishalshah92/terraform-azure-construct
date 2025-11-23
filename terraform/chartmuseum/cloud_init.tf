module "cloud_init" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/cloud-init-microservice?ref=0.3"

  # Custom data Config
  azure_identity_login = false
  acr_login            = false
  docker_login         = true
  login_server         = "${var.acr_login_server}.azurecr.io"
  username             = data.azurerm_container_registry.container_registry.admin_username
  password             = data.azurerm_container_registry.container_registry.admin_password
  #azure_user_identity_object_id = azurerm_user_assigned_identity.vmss_user_identity.id
  docker_compose_content = data.template_file.dynamic_backend_service_docker_compose.rendered

  # Telegraf
  enable_telegraf              = true
  telegraf_out_influxdb_host   = var.telegraf_out_influxdb_host
  telegraf_out_influxdb_token  = data.azurerm_key_vault_secret.devops_keyvault_influxdb_token.value
  telegraf_out_influxdb_org    = var.telegraf_out_influxdb_org
  telegraf_out_influxdb_bucket = var.telegraf_out_influxdb_bucket

  # Tags
  tags = local.tags
}