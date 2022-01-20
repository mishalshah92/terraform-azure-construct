module "redis_cache" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/cache-redis?ref=1.3"

  name     = local.name
  location = var.location

  # Config
  sku_name       = var.sku_name
  family         = var.family
  capacity       = var.capacity
  shard_count    = var.shard_count
  patch_schedule = var.patch_schedule

  # Network
  subnet_id                     = data.azurerm_subnet.redis_subnet.id
  zones                         = var.zones
  public_network_access_enabled = var.public_network_access_enabled
  private_static_ip_address     = var.private_static_ip_address
  enable_non_ssl_port           = var.enable_non_ssl_port
  minimum_tls_version           = var.minimum_tls_version

  # Redis configurations
  redis_configurations = var.redis_configurations

  # Tags
  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}

resource "azurerm_redis_firewall_rule" "firewall_ip_rules" {

  for_each = var.firewall_rules

  name                = each.key
  redis_cache_name    = local.name
  resource_group_name = var.resource_group
  start_ip            = each.value.start_ip
  end_ip              = each.value.end_ip

  depends_on = [
    module.redis_cache
  ]
}