locals {
  network_subnets = flatten([
    for rule_name, network in data.azurerm_subnet.allowed_subnet : [
      network.id
    ]
  ])
}

module "vnet_storage_account" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/storage-account?ref=2.9"

  name     = var.name
  location = var.location

  account_kind             = var.storage_acc_kind
  account_tier             = var.storage_acc_tier
  account_replication_type = var.storage_acc_replication_type
  large_file_share_enabled = var.large_file_share_enabled

  min_tls_version = "TLS1_2"

  network_rules = [
    {
      default_action             = var.vnet_rule
      bypass                     = ["Metrics", "AzureServices"]
      virtual_network_subnet_ids = local.network_subnets
    }
  ]

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

resource "azurerm_storage_container" "storage_container" {

  for_each = var.storage_blob_containers

  name                  = each.key
  container_access_type = lookup(each.value, "container_access_type", "private")
  storage_account_name  = module.vnet_storage_account.name
  metadata              = lookup(each.value, "metadata", null)
}