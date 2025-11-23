# ElasticSearch

variable "hostname" {
  type = string
}

## Env

variable "elasticsearch_storage_account" {
  type = string
}

variable "elasticsearch_data_disk" {
  type    = list(any)
  default = []
}

variable "elasticsearch_java_heap_memory" {
  type    = string
  default = "1g"
}

## Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "elasticsearch_service_port" {
  type = number
}

variable "elasticsearch_health_check_protocol" {
  type = string
}

variable "elasticsearch_health_check_path" {
  type = string
}

variable "elasticsearch_health_check_response_code" {
  type = string
}

variable "kibana_service_port" {
  type = number
}

variable "kibana_health_check_protocol" {
  type = string
}

variable "kibana_health_check_path" {
  type = string
}

variable "kibana_health_check_response_code" {
  type = string
}

## Docker configs

variable "elasticsearch_service_tag" {
  type = string
}

variable "kibana_service_tag" {
  type = string
}

## Scaling Config

variable "elasticsearch_kibana_vm_type" {
  type = string
}

variable "elasticsearch_kibana_max_instances" {
  type = number
}

variable "elasticsearch_kibana_min_instances" {
  type = number
}

variable "elasticsearch_kibana_scale_in_policy" {
  type = string
}

variable "elasticsearch_kibana_scale_overprovision" {
  type = bool
}

variable "elasticsearch_kibana_priority" {
  type = string
}