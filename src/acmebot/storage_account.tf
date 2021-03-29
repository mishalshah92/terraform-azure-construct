module "storage_account" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/storage-account?ref=master"

  name     = local.storage_account_name
  location = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"

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