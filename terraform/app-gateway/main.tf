terraform {
  required_version = ">= 0.14.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.81.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

locals {

  cloud = "azure"
  name  = "${var.module}-${var.deployment}-${var.location}"

  default_tags = {
    Name          = var.deployment
    Customer      = var.customer
    Env           = var.env
    Deployment    = var.deployment
    Email         = var.email
    Owner         = var.owner
    Repo          = var.repo
    ResourceGroup = var.resource_group
    Module        = var.module
  }

  tags = merge(local.default_tags, var.tags)

}