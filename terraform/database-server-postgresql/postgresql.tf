module "postgresql-db" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/database-server-postgresql?ref=1.8"

  name     = local.name
  location = var.location

  # Config
  create_mode                   = var.create_mode
  sku_name                      = var.sku_name
  db_version                    = var.db_version
  public_network_access_enabled = var.public_network_access_enabled

  # Auth
  administrator_username = var.administrator_username
  administrator_password = random_password.postgres_password.result

  # Storage
  auto_grow_enabled = var.auto_grow_enabled
  storage_mb        = var.storage_mb

  # Encryption & SSL
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  ssl_enforcement_enabled           = var.ssl_enforcement_enabled
  ssl_minimal_tls_version_enforced  = var.ssl_minimal_tls_version_enforced

  # Backup
  backup_retention_days        = var.backup_retention_days
  geo_redundant_backup_enabled = var.geo_redundant_backup_enabled

  # Threat Detection
  threat_detection_policy = var.threat_detection_policy

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