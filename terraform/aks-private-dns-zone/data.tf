data "azurerm_virtual_network" "vnet" {

  for_each = var.vnet_names

  name                = each.key
  resource_group_name = each.value
}