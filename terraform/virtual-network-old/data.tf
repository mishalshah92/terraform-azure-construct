data "azurerm_resource_group" "resource_group" {
  name = var.resource_group
}

//data "azurerm_network_watcher" "network_watcher" {
//  name                = "${data.azurerm_resource_group.resource_group.name}-nat-watcher"
//  resource_group_name = data.azurerm_resource_group.resource_group.name
//}

data "azurerm_network_watcher" "network_watcher" {
  name                = "NetworkWatcher_${data.azurerm_resource_group.resource_group.location}"
  resource_group_name = "NetworkWatcherRG"
}