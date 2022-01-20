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

## AAD

variable "owner_names" {
  type    = set(string)
  default = []
}

## Resource Permission

variable "acr_pull_role" {
  type    = map(string)
  default = {}
}

variable "rg_reader_role" {
  type    = set(string)
  default = []
}

variable "dnszone_contributor_role" {
  type    = map(string)
  default = {}
}

variable "private_dnszone_contributor_role" {
  type    = map(string)
  default = {}
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