resource "azurerm_logic_app_integration_account" "integration_account" {
  name                = var.name
  resource_group_name = var.resource_group
  location            = var.location
  sku_name            = var.integration_account_sku_name

  tags = local.tags
}