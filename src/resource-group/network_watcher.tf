resource "azurerm_network_watcher" "network_watcher" {
  name                = "${var.name}-nat-watcher"
  location            = var.location
  resource_group_name = module.default.hub_rg.name

  tags = module.default.tags

  depends_on = [
    module.resource-group
  ]
}