module "vnet_storage_account" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/storage-account?ref=master"

  name     = var.storage_acc_name == null ? replace("${var.resource_group}${var.name}sa", "-", "") : var.storage_acc_name
  location = data.azurerm_resource_group.resource_group.location

  account_tier             = var.storage_acc_tier
  account_replication_type = var.storage_acc_replication_type

  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  git_commit     = var.git_commit
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}