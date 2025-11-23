module "vnet_gateway" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/virtual-network-gateway?ref=0.3"

  name              = var.name
  location          = var.location
  vpn_type          = var.vpn_type
  gateway_subnet_id = data.azurerm_subnet.gateway_subnet.id
  active_active     = var.active_active
  enable_bgp        = var.enable_bgp
  sku               = var.sku
  generation        = var.generation

  pts_address_spaces        = var.pts_address_spaces
  pts_vpn_client_protocols  = var.pts_vpn_client_protocols
  pts_root_certificate_name = var.pts_root_certificate_name
  pts_root_certificate_data = data.local_file.vpn_certificate_path.content

  # Tags
  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}