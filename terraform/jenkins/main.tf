terraform {
  required_version = ">= 0.14.6"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.84.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.7.0"
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
  cloud                = "azure"
  name                 = "${var.module}-${var.resource_group}-${var.deployment}"
  computer_name_prefix = "${title(var.module)}${title(var.name)}"

  jenkins_data_path                          = "/jenkinsdatadir/${var.jenkins_storage_account}/${local.name}"
  jenkins_credentials_data_path              = "/jenkinsdatadir/${var.jenkins_storage_account}/${local.name}/credentials"
  jenkins_local_data_path                    = "/jenkinsdatadir/local"
  jenkins_master_health_request_path         = "/metrics/${random_password.metric_key.result}/healthcheck"
  keyvault_jenkins_master_secret_name_prefix = "${var.resource_group}-jenkins-${var.name}-master"

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