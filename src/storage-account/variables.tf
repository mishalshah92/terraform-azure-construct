variable "location" {
  type = string
}

variable "hub_rg" {
  type = string
}

# Storage account

variable "name" {
  type = string
}

variable "storage_acc_tier" {
  type    = string
  default = "Standard"
}

variable "storage_acc_replication_type" {
  type    = string
  default = "LRS"
}

variable "storage_blob_containers" {
  type    = map(any)
  default = {}
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