module "cloud_init" {
  source = "git::https://github.com/cloudops92/terraform-azure-core-modules.git//terraform/cloud-init-microservice?ref=0.3"

  # Custom data Config
  azure_identity_login   = false
  acr_login              = false
  docker_login           = true
  login_server           = "${var.acr_login_server}.azurecr.io"
  username               = data.azurerm_container_registry.container_registry.admin_username
  password               = data.azurerm_container_registry.container_registry.admin_password
  docker_compose_content = data.template_file.docker_compose.rendered
}

module "chartmuseum" {
  source = "git::https://github.com/cloudops92/terraform-azure-microservice-modules.git//terraform/chartmuseum?ref=0.3"

  resource_group = var.resource_group
  location       = var.location

  # Hub Resources
  acr_login_server = var.acr_login_server
  hub_rg           = var.hub_rg
  vm_image_name    = var.vm_image_name
  cert_key_vault   = var.cert_key_vault
  caching          = var.caching
  dns_zone         = var.dns_zone

  # base config
  private_deploy         = var.private_deploy
  disk_size_gb           = var.disk_size_gb
  admin_ssh_keys         = var.admin_ssh_keys
  admin_username         = var.admin_username
  single_placement_group = var.single_placement_group
  storage_account_type   = var.storage_account_type
  subnet_name            = var.subnet_name
  virtual_network_name   = var.virtual_network_name

  # Network
  zone_balance = var.zone_balance
  zones        = var.zones

  # App Gateway
  app_gateway_enable_http2 = var.app_gateway_enable_http2
  app_gateway_max_instance = var.app_gateway_max_instance
  app_gateway_min_instance = var.app_gateway_min_instance
  app_gateway_nsg_name     = var.app_gateway_nsg_name
  app_gateway_sku_name     = var.app_gateway_sku_name
  app_gateway_sku_tier     = var.app_gateway_sku_tier
  app_gateway_subnet_name  = var.app_gateway_subnet_name
  app_gateway_private_ip   = var.app_gateway_private_ip
  app_gateway_ssl_policy   = var.app_gateway_ssl_policy

  # Service Variable
  chart_museum_health_check_path     = var.chart_museum_health_check_path
  chart_museum_health_check_protocol = var.chart_museum_health_check_protocol
  chart_museum_max_instances         = var.chart_museum_max_instances
  chart_museum_min_instances         = var.chart_museum_min_instances
  chart_museum_priority              = var.chart_museum_priority
  chart_museum_scale_in_policy       = var.chart_museum_scale_in_policy
  chart_museum_scale_overprovision   = var.chart_museum_scale_overprovision
  chart_museum_service_port          = var.chart_museum_service_port
  chart_museum_service_tag           = var.chart_museum_service_port
  chart_museum_storage_account       = var.chart_museum_storage_account
  chart_museum_storage_container     = var.chart_museum_storage_container
  chart_museum_vm_type               = var.chart_museum_vm_type
  chart_museum_base64_cloud_init     = module.cloud_init.cloud_init_base64_encoded

  # Alert config
  alert_action_group_name = var.alert_action_group_name
  alert_emails            = var.alert_emails
  enable_alerts           = var.enable_alerts

  # Tags
  customer   = var.customer
  deployment = var.deployment
  email      = var.email
  env        = var.env
  git_commit = var.git_commit
  module     = var.module
  name       = var.name
  owner      = var.owner
  repo       = var.repo
  tags       = var.tags

}