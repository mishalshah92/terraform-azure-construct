variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

# AKS

variable "aks_cluster_name" {
  type = string
}

variable "location" {
  type = string
}

variable "scope" {
  type = map(any)
}

variable "users" {
  type    = map(any)
  default = null
}

variable "groups" {
  type    = map(any)
  default = null
}

variable "group_membership" {
  type    = map(any)
  default = null
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