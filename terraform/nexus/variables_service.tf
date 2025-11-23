variable "nexus_storage_account" {
  type = string
}

## nexus- Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "nexus_service_port" {
  type = number
}

variable "nexus_health_check_protocol" {
  type = string
}

variable "nexus_health_check_request_path" {
  type = string
}

variable "nexus_tag" {
  type = string
}

## nexus - Scaling Config

variable "nexus_vm_type" {
  type = string
}

variable "nexus_max_instances" {
  type = number
}

variable "nexus_min_instances" {
  type = number
}

variable "nexus_scale_in_policy" {
  type = string
}

variable "nexus_scale_overprovision" {
  type = bool
}

variable "nexus_priority" {
  type = string
}

