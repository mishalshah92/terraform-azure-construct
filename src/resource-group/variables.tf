variable "name" {
  type = string
}

variable "location" {
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

variable "module" {
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