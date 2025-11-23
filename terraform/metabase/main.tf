terraform {
  required_version = ">= 0.14.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.65.0"
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
  cloud                = "azure"
  name                 = "${var.module}-${var.resource_group}-${var.deployment}"
  computer_name_prefix = "${title(var.module)}${title(var.name)}"

  metabase_data_path = "/metabase/${var.metabase_storage_account}/${local.name}"

  default_tags = {
    Name          = var.name
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