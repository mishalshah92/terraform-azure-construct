variable "location" {
  type = string
}

variable "name" {
  type = string
}

# Slack
variable "slack_channel_id" {
  type = string
}

variable "slack_username" {
  type = string
}

variable "slack_webhook_uri" {
  type = string
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