terraform {
  required_version = "> 0.13"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.44.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "1.0.0"
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
  #  tenant_id = var.tenant_id
}

locals {

  app_service_plan_name = "${var.name}-acmebot"
  app_insights_name     = "${var.name}-acmebot"
  ad_application_name   = "${var.name}-acmebot"
  function_app_name     = "${var.name}-acmebot"
  key_vault_name        = "${var.name}-acmebot"
  storage_account_name  = lower("${replace(var.name, "-", "")}acmebot")

  keyvault_admins = concat([var.email], var.keyvault_admins)

  default_tags = {
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
