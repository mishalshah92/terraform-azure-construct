module "nsg-flow-logs" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/network-watcher-flow-log?ref=0.1"

  network_watcher_name = data.azurerm_network_watcher.network_watcher.name
  resource_group       = data.azurerm_network_watcher.network_watcher.resource_group_name

  network_security_group_id = data.azurerm_resources.aks_default_agent_pool_nsg.resources[0].id
  storage_account_id        = data.azurerm_storage_account.vnet_storage_account.id

  enable_retention_policy = true
  retention_days          = 7
}