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