terraform {
  required_version = "> 0.13"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {

  resource_group_name = "${var.customer}-${var.env}"

  default_tags = {
    Customer      = var.customer
    Owner         = var.owner
    Env           = var.env
    Email         = var.email
    Repo          = var.repo
    Tool          = var.tool
    ResourceGroup = var.resource_group
    Module        = var.module
    Deployment    = var.deployment
  }

  tags = merge(local.default_tags, var.tags)
}