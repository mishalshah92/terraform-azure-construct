variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

# Static Resources

variable "hub_rg" {
  type = string
}

# Config

variable "name" {
  type = string
}

variable "enable_automatic_failover" {
  type = bool
}

variable "enable_free_tier" {
  type = bool
}

variable "public_network_access_enabled" {
  type = bool
}

variable "is_virtual_network_filter_enabled" {
  type = bool
}

variable "enable_multiple_write_locations" {
  type = bool
}

variable "virtual_network_rule" {
  type    = map(any)
  default = {}
}

variable "capabilities" {
  type    = list(any)
  default = []
}

variable "consistency_policy" {
  type = list(any)
}

variable "geo_locations" {
  type = list(any)
}

variable "keyvault_name" {
  type    = string
  default = null
}

# Alerts notifications

variable "alert_action_group_name" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
}

# Private Endpoint

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "enable_private_link" {
  type    = bool
  default = false
}

variable "private_dns_zone_name" {
  type = string
}

variable "res_dns_zone" {
  type = string
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