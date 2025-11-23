## rancher- Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "rancher_admin_email" {
  type = string
}

variable "rancher_service_port" {
  type = number
}

variable "rancher_acme_domain" {
  type = string
}

variable "rancher_tag" {
  type = string
}

variable "resource_group_list" {
  type    = list(string)
  default = []
}

## rancher - Scaling Config

variable "rancher_vm_size" {
  type = string
}

variable "rancher_vm_priority" {
  type = string
}

variable "rancher_volume_size" {
  type = number
}

variable "rancher_volume_disk" {
  type = string
}

variable "rancher_data_path" {
  type = string
}

