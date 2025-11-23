locals {
  virtual_network_rule = flatten([
    for subnet, subnet_info in data.azurerm_subnet.vnet_subnet : [
      {
        id                                   = subnet_info.id
        ignore_missing_vnet_service_endpoint = false
      }
    ]
  ])
}

module "cosmosdb_account" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/cosmosdb-account?ref=0.3"

  name       = local.name
  location   = var.location
  offer_type = "Standard"
  kind       = "MongoDB"

  enable_free_tier                  = var.enable_free_tier
  enable_automatic_failover         = var.enable_automatic_failover
  enable_multiple_write_locations   = var.enable_multiple_write_locations
  public_network_access_enabled     = var.public_network_access_enabled
  is_virtual_network_filter_enabled = var.is_virtual_network_filter_enabled

  virtual_network_rule = local.virtual_network_rule
  capabilities         = var.capabilities
  consistency_policy   = var.consistency_policy
  geo_locations        = var.geo_locations

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