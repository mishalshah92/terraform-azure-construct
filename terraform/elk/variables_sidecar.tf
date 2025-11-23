# Logging

variable "filebeat_tag" {
  type = string
}

variable "es_host" {
  type = string
}

variable "es_username" {
  type = string
}

variable "es_password_keyvault_secret_name" {
  type = string
}

variable "kibana_host" {
  type = string
}