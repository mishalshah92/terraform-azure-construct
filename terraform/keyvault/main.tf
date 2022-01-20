terraform {
  required_version = "> 0.14.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.51.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.4.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "azuread" {
  tenant_id = var.tenant_id
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