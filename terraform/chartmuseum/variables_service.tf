# Env

variable "chart_museum_storage_account" {
  type = string
}

variable "chart_museum_storage_container" {
  type = string
}

# Service Config

variable "chart_museum_service_port" {
  type = number
}

variable "chart_museum_health_check_protocol" {
  type = string
}

variable "chart_museum_health_check_path" {
  type = string
}

# Docker configs

variable "chart_museum_service_tag" {
  type = string
}

# Scaling Config

variable "chart_museum_vm_type" {
  type = string
}

variable "chart_museum_max_instances" {
  type = number
}

variable "chart_museum_min_instances" {
  type = number
}

variable "chart_museum_scale_in_policy" {
  type = string
}

variable "chart_museum_scale_overprovision" {
  type = bool
}

variable "chart_museum_priority" {
  type = string
}