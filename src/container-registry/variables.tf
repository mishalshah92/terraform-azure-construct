variable "location" {
  type = string
}

variable "name" {
  type = string
}

variable "sku" {
  type = string
}

variable "admin_enabled" {
  type = bool
}

variable "georeplication_locations" {
  type = list
}

# Networking

variable "network_rule_set" {
  type = map
}

variable "retention_days" {
  type = number
}

variable "trust_policy" {
  type = bool
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