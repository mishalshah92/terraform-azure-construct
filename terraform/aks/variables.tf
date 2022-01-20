variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

# Generic Resource

variable "acr_login_server" {
  type = string
}

variable "hub_rg" {
  type = string
}

# AKS

variable "name" {
  type = string
}

variable "location" {
  type = string
}

## Basic Configurations

variable "kubernetes_version" {
  type = string
}

variable "sku_tier" {
  type = string
}

## Scaling

variable "auto_scaler_profile" {
  type    = list(any)
  default = []
}

## Default node pool

variable "default_node_pool" {
  type    = list(any)
  default = []
}

## Network

variable "vnet" {
  type = string
}

variable "dns_prefix" {
  type    = string
  default = null
}

variable "private_cluster_enabled" {
  type    = bool
  default = false
}

variable "private_cluster_public_fqdn_enabled" {
  type    = bool
  default = false
}

variable "network_profile" {
  type    = list(any)
  default = []
}

variable "network_load_balancer_profile" {
  type    = list(any)
  default = []
}

## Linux

variable "admin_username" {
  type = string
}

## Authentication & Authorization

variable "role_based_access_control" {
  type    = list(any)
  default = []
}

## Addons

variable "addon_profile" {
  type    = list(any)
  default = []
}

## Upgrade && Maintenance

variable "automatic_channel_upgrade" {
  type    = string
  default = "node-image"
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