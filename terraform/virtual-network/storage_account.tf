module "vnet_storage_account" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/storage-account?ref=3.3"

  name     = replace("${var.name}sa", "-", "")
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