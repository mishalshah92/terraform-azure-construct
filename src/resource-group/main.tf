terraform {
  required_version = "> 0.15"
}

provider "azurerm" {
  features {}
}

module "tags" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src/tags?ref=add-tag-module"

  customer       = var.customer
  env            = var.env
  deployment     = var.deployment
  owner          = var.owner
  email          = var.email
  resource_group = var.name
  module         = var.module
  tags           = var.tags
}