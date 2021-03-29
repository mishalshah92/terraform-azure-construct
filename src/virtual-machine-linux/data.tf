data "azurerm_proximity_placement_group" "placement_group" {

  count = var.proximity_placement_group_name == null ? 0 : 1

  name                = var.proximity_placement_group_name
  resource_group_name = var.resource_group
}

data "azurerm_virtual_machine_scale_set" "virtual_machine_scale_set" {

  count = var.virtual_machine_scale_set_name == null ? 0 : 1

  name                = var.virtual_machine_scale_set_name
  resource_group_name = var.resource_group
}

data "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}

data "azurerm_image" "source_image" {

  count = var.source_image_name == null ? 0 : 1

  name                = var.source_image_name
  resource_group_name = var.hub_rg
}

data "azurerm_container_registry" "container_registry" {
  name                = var.acr_login_server
  resource_group_name = var.hub_rg
}

data "azurerm_storage_account" "app_config_storage_account" {
  name                = "ddaiconfig${var.location}"
  resource_group_name = var.hub_rg
}

data "azurerm_key_vault" "rg_keyvault" {
  name                = var.resource_group
  resource_group_name = var.resource_group
}