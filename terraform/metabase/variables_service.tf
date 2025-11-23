## metabase- Service Config

variable "metabase_storage_account" {
  type = string
}

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "metabase_service_port" {
  type = number
}

variable "metabase_health_check_protocol" {
  type = string
}

variable "metabase_health_check_request_path" {
  type = string
}

variable "metabase_tag" {
  type = string
}

## metabase DB

variable "metabase_database_username" {
  type = string
}

variable "keyvault_metabase_secret_name_prefix" {
  type = string
}

variable "metabase_database_host" {
  type = string
}

variable "metabase_database_name" {
  type = string
}

## metabase - Scaling Config

variable "metabase_vm_type" {
  type = string
}

variable "metabase_max_instances" {
  type = number
}

variable "metabase_min_instances" {
  type = number
}

variable "metabase_scale_in_policy" {
  type = string
}

variable "metabase_scale_overprovision" {
  type = bool
}

variable "metabase_priority" {
  type = string
}

