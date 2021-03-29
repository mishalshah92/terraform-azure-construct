variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "verification_email" {
  type = string
}

variable "webhook_url" {
  type    = string
  default = "https://hooks.slack.com/services/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"
}

# Keyvault Network

variable "keyvault_admins" {
  type    = list(any)
  default = []
}

variable "keyvault_network_default_action" {
  type    = string
  default = "Allow"
}

variable "keyvault_network_ip_rules" {
  type    = list(any)
  default = []
}

variable "keyvault_network_subnet_map" {
  type    = map(any)
  default = {}
}

variable "keyvault_notification_contacts" {
  type    = list(any)
  default = []
}

# Azure DNS

variable "dns_zones" {
  type    = map(any)
  default = {}
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