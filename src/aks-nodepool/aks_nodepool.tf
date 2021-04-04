module "aks_nodepool" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/aks-nodepool?ref=0.1"

  name = var.name

  # Kubernetes
  kubernetes_cluster_id = data.azurerm_kubernetes_cluster.aks.id
  orchestrator_version  = data.azurerm_kubernetes_cluster.aks.kubernetes_version
  mode                  = var.mode

  # Pods
  max_pods = var.max_pods
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
  proximity_placement_group_id = var.proximity_placement_group_id

  # Network
  vnet_subnet_id     = data.azurerm_subnet.vnet_subnet.id
  availability_zones = var.availability_zones

  # Spot
  priority        = var.priority
  eviction_policy = var.eviction_policy
  spot_max_price  = var.spot_max_price

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