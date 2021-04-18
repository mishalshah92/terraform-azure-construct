variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "private_zone_postfix" {
  type = string
}

variable "hub_resource_group" {
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

variable "repo" {
  type = string
}

variable "deployment" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}