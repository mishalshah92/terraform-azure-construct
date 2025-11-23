variable "sonarqube_storage_account" {
  type = string
}

## sonarqube- Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "sonarqube_service_port" {
  type = number
}

variable "sonarqube_health_check_protocol" {
  type = string
}

variable "sonarqube_health_check_request_path" {
  type = string
}

variable "sonarqube_tag" {
  type = string
}

## Sonarqube DB

variable "sonarqube_database_username" {
  type = string
}

variable "keyvault_sonarqube_secret_name_prefix" {
  type = string
}

variable "sonarqube_database_host" {
  type = string
}

variable "sonarqube_database_name" {
  type = string
}


## sonarqube - Scaling Config

variable "sonarqube_vm_type" {
  type = string
}

variable "sonarqube_max_instances" {
  type = number
}

variable "sonarqube_min_instances" {
  type = number
}

variable "sonarqube_scale_in_policy" {
  type = string
}

variable "sonarqube_scale_overprovision" {
  type = bool
}

variable "sonarqube_priority" {
  type = string
}

