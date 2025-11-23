variable "influxdb_storage_account" {
  type = string
}

## Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "influxdb_service_port" {
  type = number
}

variable "influxdb_health_check_protocol" {
  type = string
}

variable "influxdb_health_check_request_path" {
  type = string
}

variable "influxdb_tag" {
  type = string
}

## nexus - Scaling Config

variable "influxdb_vm_type" {
  type = string
}

variable "influxdb_max_instances" {
  type = number
}

variable "influxdb_min_instances" {
  type = number
}

variable "influxdb_scale_in_policy" {
  type = string
}

variable "influxdb_scale_overprovision" {
  type = bool
}

variable "influxdb_priority" {
  type = string
}

