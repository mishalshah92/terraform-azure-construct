variable "location" {
  type = string
}

# VPC

variable "name" {
  type = string
}

variable "address_spaces" {
  type = list(any)
}

variable "dns_servers" {
  type = list(any)
}

variable "enable_ddos" {
  type = bool
}

variable "private_dns_zone_name_postfix" {
  type    = string
  default = null
}

variable "resources_rg" {
  type = string
}

# Subnets

variable "subnet_address_spaces" {
  type    = map(any)
  default = {}
}

variable "gateway_subnet_address_spaces" {
  type = list(any)
}

# Routes

variable "routes" {
  type    = map(any)
  default = {}
}

# NSG

variable "nsg_rules" {
  type    = map(any)
  default = {}
}

# Storage account

variable "storage_acc_tier" {
  type    = string
  default = "Standard"
}

variable "storage_acc_replication_type" {
  type    = string
  default = "LRS"
}

# Flow logs

variable "enable_retention_policy" {
  type = bool
}

variable "retention_days" {
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