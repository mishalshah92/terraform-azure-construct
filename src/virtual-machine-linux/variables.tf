variable "location" {
  type = string
}

variable "name" {
  type = string
}

# Static Resources

variable "acr_login_server" {
  type = string
}

variable "hub_rg" {
  type = string
}

# Secrets

variable "secret" {
  type    = map(any)
  default = {}
}

# Source Image

variable "source_image_name" {
  type    = string
  default = null
}

variable "source_image_publisher" {
  type    = string
  default = null
}

variable "source_image_offer" {
  type    = string
  default = null
}

variable "source_image_sku" {
  type    = string
  default = null
}

variable "source_image_version" {
  type    = string
  default = null
}

# identity

variable "admin_username" {
  type = string
}

variable "admin_ssh_keys" {
  type = map(any)
}

# Config

variable "size" {
  type = string
}

variable "virtual_machine_scale_set_name" {
  type = string
}

variable "proximity_placement_group_name" {
  type = string
}

variable "base64_custom_data" {
  type = string
}

variable "priority" {
  type = string
}


# Network

variable "vnet_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "enable_ip_forwarding" {
  type = bool
}

variable "enable_accelerated_networking" {
  type = bool
}

variable "public_ip" {
  type = bool
}

variable "private_ip_address_version" {
  type = string
}

variable "private_ip_address_allocation" {
  type = string
}

variable "primary_ip_config" {
  type = bool
}

variable "zone" {
  type = string
}

# Storage

variable "caching" {
  type = string
}

variable "storage_account_type" {
  type = string
}

variable "disk_size_gb" {
  type = number
}

variable "write_accelerator_enabled" {
  type = bool
}

variable "disk_encryption_set_id" {
  type = string
}

# Auto Shutdown

variable "auto_shutdown_enabled" {
  type = bool
}

variable "auto_shutdown_time" {
  type = string
}

# Possible Timezone: https://jackstromberg.com/2017/01/list-of-time-zones-consumed-by-azure/
variable "auto_shutdown_timezone" {
  type = string
}

# Alerts notifications

variable "alert_action_group_name" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
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