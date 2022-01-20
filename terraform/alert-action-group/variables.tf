variable "subscription_id" {
  type = string
}

variable "tenant_id" {
  type = string
}

variable "location" {
  type = string
}


variable "name" {
  type = string
}

# Alerts notifications

variable "slack_notifier_logic_app_name" {
  type = string
}

variable "slack_notifier_logic_app_endpoint" {
  type = string
}

variable "alert_emails" {
  type    = list(any)
  default = []
}

variable "alert_logic_app" {
  type    = list(map(any))
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