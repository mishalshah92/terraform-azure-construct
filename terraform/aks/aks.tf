locals {
  aks_dns_prefix = var.name
}

module "aks_cluster" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/aks?ref=0.3"

  name           = var.name
  location       = var.location
  resource_group = var.resource_group

  ## Basic Configurations
  sku_tier           = var.sku_tier
  kubernetes_version = var.kubernetes_version

  ## Scaling
  auto_scaler_profile = var.auto_scaler_profile

  ## Default node pool
  node_resource_group    = local.node_group_rg_name
  default_node_pool      = var.default_node_pool
  default_node_pool_tags = local.tags

  ## Network
  private_dns_zone_id                 = data.azurerm_private_dns_zone.aks_private_dns_zone.id
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled

  #dns_prefix_private_cluster = var.private_cluster_enabled ? local.aks_dns_prefix : null
  dns_prefix = local.aks_dns_prefix

  network_profile               = var.network_profile
  network_load_balancer_profile = var.network_load_balancer_profile

  ## Authentication & Authorization
  role_based_access_control = var.role_based_access_control

  ## Linux Profile
  disk_encryption_set_id = azurerm_disk_encryption_set.disk_encryption_set.id
  linux_profile = [
    {
      admin_username = var.admin_username
      ssh_key_data   = data.azurerm_ssh_public_key.ssh_key.public_key
    }
  ]

  ## Addons
  addon_profile = var.addon_profile

  ## Identity
  identity = [
    {
      type                      = "UserAssigned"
      user_assigned_identity_id = azurerm_user_assigned_identity.aks_master_user_identity.id
    }
  ]

  ## Upgrade && Maintenance
  automatic_channel_upgrade = var.automatic_channel_upgrade

  ## Tags
  customer   = var.customer
  env        = var.env
  owner      = var.owner
  email      = var.email
  repo       = var.repo
  tags       = var.tags
  deployment = var.deployment
  module     = var.module

  depends_on = [
    azurerm_role_assignment.aks_master_user_identity_private_dns_zone_contributor,
    azurerm_role_assignment.aks_master_user_identity_net_contributor,
    azurerm_role_assignment.aks_master_user_identity_key_vault_secret_user
  ]

}

