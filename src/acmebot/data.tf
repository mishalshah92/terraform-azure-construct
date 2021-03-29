data "azurerm_client_config" "current" {
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "azuread_users" "keyvault_admins" {
  user_principal_names = local.keyvault_admins
}

data "azurerm_dns_zone" "dns_zones" {

  for_each = var.dns_zones

  name                = each.key
  resource_group_name = each.value
}

data "azurerm_subnet" "allowed_subnet" {

  for_each = var.keyvault_network_subnet_map

  name                 = each.value.name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.resource_group
}

data "azuread_service_principal" "active_directory" {
  display_name = "Windows Azure Active Directory"
}

data "azuread_service_principal" "microsoft_graph" {
  display_name = "Microsoft Graph"
}