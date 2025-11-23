module "container_registry" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/container-registry?ref=0.2"

  name                     = var.name
  location                 = var.location
  sku                      = var.sku
  admin_enabled            = var.admin_enabled
  georeplication_locations = var.georeplication_locations

  network_rule_set = var.network_rule_set
  retention_days   = var.retention_days
  trust_policy     = var.trust_policy

  # Tags
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