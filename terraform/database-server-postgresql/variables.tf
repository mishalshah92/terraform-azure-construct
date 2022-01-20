variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "create_mode" {
  type = string
}

variable "sku_name" {
  type = string
}

variable "db_version" {
  type = string
}

variable "public_network_access_enabled" {
  type = bool
}

# Networking

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "vent_rule_allowed_subnet_names" {
  type    = map(any)
  default = {}
}

variable "enable_private_link" {
  type    = bool
  default = false
}

variable "private_dns_zone_name" {
  type = string
}

variable "hub_rg" {
  type = string
}

variable "res_dns_zone" {
  type = string
}

# Auth

variable "administrator_username" {
  type = string
}

# Storage

variable "auto_grow_enabled" {
  type = bool
}

variable "storage_mb" {
  type = number
}

# Encryption & SSL

variable "infrastructure_encryption_enabled" {
  type = bool
}

variable "ssl_enforcement_enabled" {
  type = bool
}

variable "ssl_minimal_tls_version_enforced" {
  type = string
}

variable "keyvault_name" {
  type    = string
  default = null
}

# Backup

variable "backup_retention_days" {
  type = number
}

variable "geo_redundant_backup_enabled" {
  type = bool
}

# Threat Detection

variable "threat_detection_policy" {
  type    = list(any)
  default = []
}

# Alerts notifications

variable "alert_action_group_name" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
}

# Tags

variable "customer" {
  type = string
}

variable "owner" {
  type = string
}

variable "email" {
  type = string
}

variable "env" {
  type = string
}

variable "git_commit" {
  type = string
}

variable "repo" {
  type = string
}

variable "deployment" {
  type = string
}

variable "module" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "tags" {
  type    = map(string)
  default = {}
}