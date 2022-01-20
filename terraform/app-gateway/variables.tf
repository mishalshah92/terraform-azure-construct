variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}

# Hub resources

variable "hub_rg" {
  type = string
}

variable "ssl_cert_key_vault" {
  type = string
}

variable "private_dns" {
  type    = map(any)
  default = {}
}

variable "public_dns" {
  type    = map(any)
  default = {}
}


# App Gateway

## Configs

variable "sku_name" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "enable_http2" {
  type = bool
}

variable "min_instance" {
  type = number
}

variable "max_instance" {
  type = number
}

## Networking

variable "virtual_network_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "zones" {
  type    = list(any)
  default = null
}

variable "private_ip" {
  type    = string
  default = null
}

# Alerts notifications

variable "enable_alerts" {
  type    = bool
  default = true
}

variable "alert_action_group_name" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
}

variable "alert_thresolds" {
  type = map(string)
  default = {
    total_time_sev1      = "500"
    total_time_sev2      = "400"
    host_count_sev1      = "0"
    failed_requests_sev1 = "15"
    failed_requests_sev2 = "10"
    client_rtt_sev3      = "500"
    response_status_sev2 = "10"
    response_status_sev3 = "20"
    response_status_sev4 = "30"
  }
}

# Tags

variable "customer" {
  type = string
}

variable "owner" {
  type = string
}

variable "email" {
  type = string
}

variable "env" {
  type = string
}

variable "git_commit" {
  type = string
}

variable "repo" {
  type = string
}

variable "deployment" {
  type = string
}

variable "module" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "tool" {
  description = "Automation tool info"
  default     = "Managed by Terraform"
}

variable "tags" {
  type    = map(string)
  default = {}
}