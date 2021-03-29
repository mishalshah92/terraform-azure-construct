variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "sku_name" {
  type = string
}

# Static Resources

variable "hub_rg" {
  type = string
}

# Config

variable "enabled_vm_for_deployment" {
  type = bool
}

variable "enabled_for_disk_encryption" {
  type = bool
}

variable "enabled_for_template_deployment" {
  type = bool
}

variable "enable_rbac_authorization" {
  type = bool
}

variable "purge_protection_enabled" {
  type = bool
}

variable "soft_delete_enabled" {
  type = bool
}

variable "soft_delete_retention_days" {
  type = number
}

# Network

variable "network_bypass" {
  type    = string
  default = "None"
}

variable "network_default_action" {
  type    = string
  default = "Deny"
}

variable "network_ip_rules" {
  type    = list(any)
  default = null
}

variable "network_subnet_map" {
  type    = map(any)
  default = {}
}

# Notifications

variable "contacts" {
  type    = list(any)
  default = []
}

# Keyvault Admins

variable "admin_user_principal_names" {
  type    = list(any)
  default = []
}

variable "admin_user_groups" {
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