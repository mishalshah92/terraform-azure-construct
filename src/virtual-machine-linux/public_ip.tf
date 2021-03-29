resource "azurerm_public_ip" "public_ip" {

  count = var.public_ip ? 1 : 0

  name                = "${var.name}-ip"
  resource_group_name = var.resource_group
  location            = var.location
  allocation_method   = "Dynamic"

  tags = local.tags
}
