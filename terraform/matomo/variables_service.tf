variable "matomo_storage_account" {
  type = string
}

variable "matomo_host" {
  type = string
}

## Matomo DB

variable "matomo_database_host" {
  type = string
}

variable "matomo_database_username" {
  type = string
}

variable "matomo_database_dbname" {
  type = string
}

variable "keyvault_matomo_secret_name_prefix" {
  type = string
}

## matomo- Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "matomo_service_port" {
  type = number
}

variable "matomo_health_check_protocol" {
  type = string
}

variable "matomo_health_check_request_path" {
  type = string
}

variable "matomo_tag" {
  type = string
}

## matomo - Scaling Config

variable "matomo_vm_type" {
  type = string
}

variable "matomo_max_instances" {
  type = number
}

variable "matomo_min_instances" {
  type = number
}

variable "matomo_scale_in_policy" {
  type = string
}

variable "matomo_scale_overprovision" {
  type = bool
}

variable "matomo_priority" {
  type = string
}

