data "azurerm_resource_group" "resource_group" {
  name = var.resource_group
}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_${var.location}"
  resource_group_name = "NetworkWatcherRG"
}