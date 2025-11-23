variable "location" {
  type = string
}

variable "name" {
  type = string
}

# Generic Resource

variable "vm_image_name" {
  type = string
}

variable "acr_login_server" {
  type = string
}

variable "dns_zone" {
  type = string
}

variable "hub_rg" {
  type = string
}

variable "cert_key_vault" {
  type = string
}

# Networking

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "zone_balance" {
  type = bool
}

variable "zones" {
  type = list(any)
}

variable "single_placement_group" {
  type = bool
}

variable "private_deploy" {
  type    = bool
  default = true
}

# OS

variable "admin_ssh_keys" {
  type = map(any)
}

variable "admin_username" {
  type = string
}

# Storage

variable "caching" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

# App Gateway

variable "app_gateway_sku_name" {
  type = string
}

variable "app_gateway_sku_tier" {
  type = string
}

variable "app_gateway_subnet_name" {
  type = string
}

variable "app_gateway_nsg_name" {
  type = string
}

variable "app_gateway_enable_http2" {
  type = bool
}

variable "app_gateway_min_instance" {
  type = number
}

variable "app_gateway_max_instance" {
  type = number
}

variable "app_gateway_private_ip" {
  type    = string
  default = null
}

variable "app_gateway_ssl_policy" {
  type    = list(any)
  default = []
}

# Alerts notifications
variable "enable_alerts" {
  type    = bool
  default = true
}

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