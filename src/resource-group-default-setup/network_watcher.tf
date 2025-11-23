resource "azurerm_network_watcher" "network_watcher" {
  name                = "${var.resource_group}-nat-watcher"
  location            = var.location
  resource_group_name = var.resource_group

  tags = module.tags.tags
}