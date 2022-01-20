terraform {
  required_version = "> 0.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.81.0"
    }
    rancher2 = {
      source  = "rancher/rancher2"
      version = "1.21.0"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}

provider "rancher2" {
  api_url    = data.azurerm_key_vault_secret.rancher_api_url.value
  access_key = data.azurerm_key_vault_secret.rancher_access_key.value
  secret_key = data.azurerm_key_vault_secret.rancher_secret_key.value
}
