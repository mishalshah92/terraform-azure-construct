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

variable "sku_name" {
  type = string
}

variable "family" {
  type = string
}

variable "capacity" {
  type = number
}

variable "shard_count" {
  type = number
}

variable "patch_schedule" {
  type = map(any)
}

variable "redis_configurations" {
  type = map(any)
}

variable "keyvault_name" {
  type    = string
  default = null
}


# Network

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type    = string
  default = "Deny"
}

variable "zones" {
  type    = list(any)
  default = null
}

variable "public_network_access_enabled" {
  type    = bool
  default = false
}

variable "private_static_ip_address" {
  type    = string
  default = null
}

variable "res_dns_zone" {
  type = string
}

variable "minimum_tls_version" {
  type    = string
  default = "1.0"
}

variable "enable_non_ssl_port" {
  type    = bool
  default = false
}

variable "firewall_rules" {
  type    = map(any)
  default = {}
}

variable "private_dns_zone_name" {
  type = string
}

# Alerts notifications

variable "alert_action_group_name" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
}

# https://azure.microsoft.com/en-in/pricing/details/cache/
variable "max_number_of_client_conn" {
  type = number
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