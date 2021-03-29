variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "aks_name" {
  type = string
}

variable "mode" {
  type = string
}

variable "max_pods" {
  type = number
}

variable "node_labels" {
  type    = map(any)
  default = null
}

variable "node_taints" {
  type    = list(any)
  default = null
}

## Network
variable "vnet_name" {
  type    = string
  default = null
}

variable "vnet_subnet_name" {
  type    = string
  default = null
}

variable "availability_zones" {
  type    = list(any)
  default = null
}

## VM config

variable "vm_size" {
  type = string
}

variable "os_disk_size_gb" {
  type    = number
  default = 15
}

variable "os_disk_type" {
  type    = string
  default = "Linux"
}

variable "proximity_placement_group_id" {
  type    = string
  default = null
}

## Autoscaling

variable "enable_auto_scaling" {
  type    = bool
  default = false
}

variable "node_count" {
  type    = number
  default = 2
}

variable "min_count" {
  type    = number
  default = 1
}

variable "max_count" {
  type    = number
  default = 5
}

## Spot Config

variable "priority" {
  type    = string
  default = "Regular"
}

variable "spot_max_price" {
  type    = number
  default = null
}

variable "eviction_policy" {
  type    = string
  default = null
}

variable "user_identity" {
  type    = map(any)
  default = {}
}

variable "hub_rg" {
  type = string
}

# Alerts notifications
variable "alert_action_group_name" {
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