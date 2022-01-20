data "azurerm_subscription" "current" {}


data "azuread_users" "owner_users" {
  user_principal_names = var.owner_names
}

data "azurerm_resource_group" "rg" {

  for_each = var.rg_reader_role

  name = each.key
}

data "azurerm_container_registry" "container_registry" {

  for_each = var.acr_pull_role

  name                = each.key
  resource_group_name = each.value
}

data "azurerm_dns_zone" "dnszone" {

  for_each = var.dnszone_contributor_role

  name                = each.key
  resource_group_name = each.value
}

data "azurerm_private_dns_zone" "private_dnszone" {

  for_each = var.private_dnszone_contributor_role

  name                = each.key
  resource_group_name = each.value
}