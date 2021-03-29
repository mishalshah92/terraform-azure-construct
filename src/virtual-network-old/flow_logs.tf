module "nsg-flow-logs" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/network-watcher-flow-log?ref=master"

  count = length(module.network-security-group)

  network_watcher_name = data.azurerm_network_watcher.network_watcher.name
  resource_group       = data.azurerm_network_watcher.network_watcher.resource_group_name

  network_security_group_id = module.network-security-group[count.index].id
  storage_account_id        = module.vnet_storage_account.id

  enable_retention_policy = var.enable_retention_policy
  retention_days          = var.retention_days

  depends_on = [
    module.network-security-group
  ]

}