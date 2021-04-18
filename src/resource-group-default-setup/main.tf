terraform {
  required_version = ">= 0.15.0"
}

provider "azurerm" {
  features {}
}

module "default" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src/default?ref=add-tag-module"

  hub_resource_group = var.hub_resource_group
}

module "tags" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src/tags?ref=add-tag-module"

  customer       = var.customer
  env            = var.env
  deployment     = var.deployment
  owner          = var.owner
  email          = var.email
  resource_group = var.resource_group
  module         = var.module
  tags           = var.tags
}