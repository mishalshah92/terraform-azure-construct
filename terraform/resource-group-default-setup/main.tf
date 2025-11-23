terraform {
  required_version = ">= 0.15.0"
}

provider "azurerm" {
  features {}
}

module "default" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/default?ref=0.3"

  hub_resource_group = var.hub_resource_group
}

module "tags" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/tags?ref=0.3"

  customer       = var.customer
  env            = var.env
  deployment     = var.deployment
  owner          = var.owner
  email          = var.email
  resource_group = var.resource_group
  module         = var.module
  tags           = var.tags
  repo           = var.repo
}