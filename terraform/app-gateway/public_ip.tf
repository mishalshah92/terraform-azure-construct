resource "azurerm_public_ip" "app_gateway_public_ip" {

  name                    = "${local.name}-${var.resource_group}-ip"
  location                = var.location
  resource_group_name     = var.resource_group
  sku                     = var.sku_name == "Standard" ? "Basic" : "Standard"
  allocation_method       = var.sku_name == "Standard" ? "Dynamic" : "Static"
  domain_name_label       = "${local.name}-${var.resource_group}-ip"
  idle_timeout_in_minutes = 5
  ip_version              = "IPv4"

  tags = local.tags

  lifecycle {
    ignore_changes = [
      name,
      domain_name_label
    ]
  }
}