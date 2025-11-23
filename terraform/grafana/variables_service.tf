variable "grafana_storage_account" {
  type = string
}

variable "grafana_server_root_url" {
  type = string
}

variable "grafana_ad_application_name" {
  type = string
}

## grafana- Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "grafana_service_port" {
  type = number
}

variable "grafana_health_check_protocol" {
  type = string
}

variable "grafana_health_check_request_path" {
  type = string
}

variable "grafana_tag" {
  type = string
}

## Grafana DB

variable "grafana_database_username" {
  type = string
}

variable "keyvault_grafana_secret_name_prefix" {
  type = string
}

variable "grafana_database_host" {
  type = string
}

variable "grafana_database_name" {
  type = string
}

## grafana - Scaling Config

variable "grafana_vm_type" {
  type = string
}

variable "grafana_max_instances" {
  type = number
}

variable "grafana_min_instances" {
  type = number
}

variable "grafana_scale_in_policy" {
  type = string
}

variable "grafana_scale_overprovision" {
  type = bool
}

variable "grafana_priority" {
  type = string
}

