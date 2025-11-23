terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.56.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "tags" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/tags?ref=0.3"

  customer       = var.customer
  env            = var.env
  deployment     = var.deployment
  owner          = var.owner
  email          = var.email
  resource_group = var.name
  module         = var.module
  repo           = var.repo
  tags           = var.tags
}