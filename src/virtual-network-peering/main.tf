terraform {
  required_version = "> 0.13"

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {

  default_tags = {
    Name          = var.name
    Customer      = var.customer
    Owner         = var.owner
    Env           = var.env
    Email         = var.email
    Commit        = var.git_commit
    Repo          = var.repo
    Tool          = var.tool
    ResourceGroup = var.resource_group
    Module        = var.module
    Deployment    = var.deployment
  }

  tags = merge(local.default_tags, var.tags)
}