module "nsg-flow-logs" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/network-watcher-flow-log?ref=3.3"

  for_each = module.subnet

  network_watcher_name = data.azurerm_network_watcher.network_watcher.name
  resource_group       = data.azurerm_network_watcher.network_watcher.resource_group_name

  network_security_group_id = each.value.nsg_id
  storage_account_id        = module.vnet_storage_account.id

  enable_retention_policy = var.enable_retention_policy
  retention_days          = var.retention_days

}