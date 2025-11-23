variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

variable "name" {
  type = string
}

# Generic Resource

variable "acr_login_server" {
  type = string
}

variable "hub_rg" {
  type = string
}

variable "devops_rg" {
  type = string
}

variable "devops_key_vault" {
  type = string
}

# VM

variable "vm_image_name" {
  type = string
}

## Networking

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "zones" {
  type = list(any)
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "private_ip_address" {
  type    = string
  default = null
}

## OS

variable "admin_ssh_keys" {
  type = map(any)
}

variable "admin_username" {
  type = string
}

## Telegraf

variable "telegraf_out_influxdb_host" {
  type = string
}

variable "telegraf_out_influxdb_token_secret_name" {
  type = string
}

variable "telegraf_out_influxdb_org" {
  type = string
}

variable "telegraf_out_influxdb_bucket" {
  type = string
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