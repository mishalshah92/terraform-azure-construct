variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "route_tables" {
  type    = list(any)
  default = []
}

# Configurations

variable "vpn_type" {
  type = string
}

variable "active_active" {
  type = bool
}

variable "enable_bgp" {
  type = bool
}

variable "sku" {
  type = string
}

variable "generation" {
  type = string
}

## pts_root_certificate

variable "pts_address_spaces" {
  type = list(any)
}

variable "pts_vpn_client_protocols" {
  type = list(any)
}

variable "pts_root_certificate_name" {
  type = string
}

variable "pts_root_certificate_path" {
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

variable "connection_count" {
  type    = number
  default = 30
}

# Static Resources

variable "hub_rg" {
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