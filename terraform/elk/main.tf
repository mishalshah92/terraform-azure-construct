terraform {
  required_version = ">= 0.14.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.76.0"
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
  module               = "elasticsearch"
  cloud                = "azure"
  name                 = "${var.module}-${var.resource_group}-${var.deployment}"
  computer_name_prefix = "${title(var.module)}${title(var.name)}"

  elk_data_path                = "/esdatadir/${var.elasticsearch_storage_account}/${data.azurerm_storage_share.elk_file_share.name}"
  keyvault_elastic_secret_name = "${var.resource_group}-elk-${var.name}-elasticsearch"

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