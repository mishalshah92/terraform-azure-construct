terraform {
  required_version = ">= 0.14.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.51.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {

  default_tags = {
    Name = var.name
    Customer = var.customer
    Env = var.env
    Deployment = var.deployment
    Email = var.email
    Owner = var.owner
    Repo = var.repo
    ResourceGroup = var.resource_group
    Module = var.module
  }
}