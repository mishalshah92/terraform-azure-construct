module "aks_cluster" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/aks?ref=master"

  name       = var.name
  dns_prefix = var.dns_prefix == null ? var.name : var.dns_prefix
  location   = var.location

  # Basic Configurations
  sku_tier               = var.sku_tier
  kubernetes_version     = var.kubernetes_version
  disk_encryption_set_id = azurerm_disk_encryption_set.disk_encryption_set.id

  # Auto-scaler
  auto_scaler_profile = [
    var.auto_scaler_profile
  ]

  # Default node pool
  node_resource_group = local.node_group_rg_name
  default_node_pool = [
    var.default_node_pool
  ]
  default_node_pool_tags = local.tags

  # Network
  network_profile = var.network_profile == null ? [] : [
    var.network_profile
  ]
  network_load_balancer_profile = var.network_load_balancer_profile == null ? [] : [
    var.network_load_balancer_profile
  ]

  # RBAC
  role_based_access_control = [
    var.role_based_access_control
  ]

  # Linux Profile
  linux_profile = [
    {
      admin_username = var.admin_username
      ssh_key_data   = file("${path.module}/keys/${var.admin_username}.pub")
    }
  ]

  # Addon profiles
  addon_profile = [
    var.addon_profile
  ]

  # Identity
  identity_type = var.identity_type

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

//resource "azurerm_role_assignment" "aks_rg_policy_insights_data_writer" {
//  scope                = data.azurerm_resource_group.aks_rg.id
//  role_definition_name = "Policy Insights Data Writer (Preview)"
//  principal_id         = module.aks_cluster.kubelet_identity.0.user_assigned_identity_id
//}