variable "location" {
  type = string
}

# Virtual network Peering

variable "name" {
  type = string
}

## Requester

variable "requester_vnet_name" {
  type = string
}

variable "requester_vnet_resource_group_name" {
  type = string
}

variable "requester_allow_virtual_network_access" {
  type = bool
}

variable "requester_allow_forwarded_traffic" {
  type = bool
}

variable "requester_allow_gateway_transit" {
  type    = bool
  default = false
}

variable "requester_use_remote_gateways" {
  type    = bool
  default = false
}

variable "requester_net_sg_name" {
  type = list(any)
}

## Acceptor

variable "acceptor_vnet_name" {
  type = string
}

variable "acceptor_vnet_resource_group_name" {
  type = string
}

variable "acceptor_allow_virtual_network_access" {
  type = bool
}

variable "acceptor_allow_forwarded_traffic" {
  type = bool
}

variable "acceptor_allow_gateway_transit" {
  type    = bool
  default = false
}

variable "acceptor_use_remote_gateways" {
  type    = bool
  default = false
}

variable "acceptor_net_sg_name" {
  type = list(any)
}

variable "nsg_rules" {
  type    = map(any)
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