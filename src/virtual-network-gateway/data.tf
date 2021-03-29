data "azurerm_subnet" "gateway_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = var.vpc_name
  resource_group_name  = var.resource_group
}

data "local_file" "vpn_certificate_path" {
  filename = "${path.root}/certs/${var.pts_root_certificate_path}"
}

data "azurerm_monitor_action_group" "slack_alert_action_group" {
  resource_group_name = var.hub_rg
  name                = var.alert_action_group_name
}