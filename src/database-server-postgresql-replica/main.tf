terraform {
  required_version = "> 0.14.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.48.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.3.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {

  name                        = "${var.resource_group}-${var.name}"
  creation_source_server_name = "${var.resource_group}-${var.creation_source_server_name}"

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