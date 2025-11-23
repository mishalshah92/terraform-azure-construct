resource "azurerm_public_ip_prefix" "aks_node_pool" {

  for_each = var.enable_node_public_ip ? [1] : toset([])

  name                = "${var.name}-public-op-prefix"
  location            = var.location
  resource_group_name = var.resource_group

  prefix_length = 31

  tags = local.tags
}

module "aks_node_pool" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/aks-nodepool?ref=3.2"

  name = var.name

  # Kubernetes
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id
  orchestrator_version  = data.azurerm_kubernetes_cluster.aks.kubernetes_version
  mode                  = var.mode

  # Pods
  max_pods      = var.max_pods
  pod_subnet_id = var.pod_subnet_name == null ? var.pod_subnet_name : data.azurerm_subnet.pod_subnet[0].id
  node_labels = merge(var.node_labels, {
    customer                     = var.customer
    deployment                   = var.deployment
    owner                        = replace(var.owner, " ", "")
    os_disk_size_gb              = var.os_disk_size_gb
    os_type                      = var.os_disk_type
    proximity_placement_group_id = var.proximity_placement_group_id
    vm_size                      = var.vm_size
  })
  node_taints = var.node_taints

  # Autoscaling
  enable_auto_scaling = var.enable_auto_scaling
  node_count          = var.node_count
  min_count           = var.min_count
  max_count           = var.max_count

  # VM config
  vm_size                      = var.vm_size
  os_disk_size_gb              = var.os_disk_size_gb
  os_disk_type                 = var.os_disk_type
  os_type                      = var.os_type
  os_sku                       = var.os_sku
  proximity_placement_group_id = var.proximity_placement_group_id
  enable_host_encryption       = var.enable_host_encryption
  fips_enabled                 = var.fips_enabled
  ultra_ssd_enabled            = var.ultra_ssd_enabled

  # Network
  vnet_subnet_id           = data.azurerm_subnet.vnet_subnet.id
  availability_zones       = var.availability_zones
  enable_node_public_ip    = var.enable_node_public_ip
  node_public_ip_prefix_id = var.enable_node_public_ip ? azurerm_public_ip_prefix.aks_node_pool[0].id : null

  # Spot
  priority        = var.priority
  eviction_policy = var.eviction_policy
  spot_max_price  = var.spot_max_price

  # kubelet config
  kubelet_disk_type = var.kubelet_disk_type
  kubelet_config    = var.kubelet_config
  linux_os_config   = var.linux_os_config

  # Upgrade Settings
  upgrade_settings = var.upgrade_settings

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