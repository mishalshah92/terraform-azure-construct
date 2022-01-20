resource "azurerm_proximity_placement_group" "vm_placement_group" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group
  tags                = local.tags
}
