data "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_cluster_name
  resource_group_name = var.resource_group
}

data "azuread_user" "azure_user" {
  for_each            = var.users != null ? var.users : {}
  user_principal_name = each.key
}

data "azuread_group" "azure_group" {
  for_each         = var.groups != null ? var.groups : {}
  display_name     = each.key
  security_enabled = true
}

data "azuread_user" "azure_user_membership" {
  for_each            = var.group_membership != null ? var.group_membership : {}
  user_principal_name = each.key
}

data "azuread_groups" "azure_group_membership" {
  for_each      = var.group_membership != null ? var.group_membership : {}
  display_names = each.value
}