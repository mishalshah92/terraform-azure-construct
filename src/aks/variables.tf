variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "dns_prefix" {
  type    = string
  default = null
}

variable "auto_scaler_profile" {
  type = object({
    balance_similar_node_groups      = bool
    max_graceful_termination_sec     = number
    scale_down_delay_after_add       = string
    scale_down_delay_after_delete    = string
    scale_down_delay_after_failure   = string
    scan_interval                    = string
    scale_down_unneeded              = string
    scale_down_unready               = string
    scale_down_utilization_threshold = string
  })
  default = null
}

variable "default_node_pool" {
  type = object({
    name                  = string
    vm_size               = string
    availability_zones    = list(any)
    enable_auto_scaling   = bool
    enable_node_public_ip = bool
    max_pods              = number
    node_labels           = map(any)
    orchestrator_version  = string
    os_disk_size_gb       = string
    os_disk_type          = string
    type                  = string
    vnet_subnet_id        = string
    max_count             = number
    min_count             = number
    node_count            = number
  })
}

variable "identity_type" {
  type = string
}

variable "user_identity" {
  type    = map(any)
  default = {}
}

variable "kubernetes_version" {
  type = string
}

variable "sku_tier" {
  type = string
}

variable "network_profile" {
  type    = map(any)
  default = null
}

variable "network_load_balancer_profile" {
  type = object({
    outbound_ports_allocated  = number
    idle_timeout_in_minutes   = number
    managed_outbound_ip_count = number
    outbound_ip_prefix_ids    = set(string)
    outbound_ip_address_ids   = set(string)
  })
  default = null
}

variable "admin_username" {
  type = string
}

variable "private_cluster_enabled" {
  type = bool
}

variable "role_based_access_control" {
  type = object({
    enabled = bool
    azure_active_directory = object({
      managed                = bool
      tenant_id              = string
      admin_group_object_ids = list(string)
      client_app_id          = string
      server_app_id          = string
      server_app_secret      = string
    })
  })
  default = null
}


variable "addon_profile" {
  type = object({
    aci_connector_linux = list(object({
      enabled     = bool
      subnet_name = string
    }))
    http_application_routing = list(object({
      enabled = bool
    }))
    azure_policy = list(object({
      enabled = bool
    }))
    kube_dashboard = list(object({
      enabled = bool
    }))
    oms_agent = list(object({
      enabled                    = bool
      log_analytics_workspace_id = string
      oms_agent_identity = list(object({
        client_id                 = string
        object_id                 = string
        user_assigned_identity_id = string
      }))
    }))
  })
  default = null
}

# Static Resources

variable "hub_rg" {
  type = string
}

variable "dns_zone" {
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