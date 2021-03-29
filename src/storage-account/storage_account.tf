module "vnet_storage_account" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/storage-account?ref=master"

  name     = var.name
  location = var.location

  account_tier             = var.storage_acc_tier
  account_replication_type = var.storage_acc_replication_type

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