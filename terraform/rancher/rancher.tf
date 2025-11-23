locals {
  app_gateway_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.Network/applicationGateways/${var.app_gateway_name}"
}

# Virtual machine scale-set

module "service_vm" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/linux-virtual-machine?ref=3.1"

  name     = local.name
  location = var.location

  # Config
  size               = var.rancher_vm_size
  priority           = var.rancher_vm_priority
  base64_custom_data = module.cloud_init.cloud_init_base64_encoded

  # Identity
  admin_username = var.admin_username
  admin_ssh_keys = [
    {
      username   = var.admin_username
      public_key = data.azurerm_ssh_public_key.ssh_key.public_key
    }
  ]

  identity_type = "UserAssigned"
  identity_ids = [
    azurerm_user_assigned_identity.rancher_vm_user_identity.id,
  ]

  # Storage
  caching                    = "ReadWrite"
  storage_account_type       = "StandardSSD_LRS"
  disk_size_gb               = "30"
  encryption_at_host_enabled = false

  # Network
  enable_ip_forwarding          = false
  enable_accelerated_networking = false
  subnet_id                     = data.azurerm_subnet.app_subnet.id
  private_ip_address_allocation = var.private_ip_address_allocation
  private_ip_address_version    = "IPv4"
  private_ip_address            = var.private_ip_address


  # OS
  source_image_id = data.azurerm_image.app_image.id

  # Shutdown
  auto_shutdown_enabled = false

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

  depends_on = [
    azurerm_user_assigned_identity.rancher_vm_user_identity,
    azurerm_role_assignment.rancher_vm_user_identity_key_vault_secrets_user,
  ]

}

resource "azurerm_managed_disk" "rancher_volume" {
  name                 = "${local.name}-rancher"
  location             = var.location
  resource_group_name  = var.resource_group
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = var.rancher_volume_size

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_virtual_machine_data_disk_attachment" "rancher_volume_disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.rancher_volume.id
  virtual_machine_id = module.service_vm.id
  lun                = "10"
  caching            = "ReadWrite"
}

resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "app_gateway_attachment" {
  network_interface_id    = module.service_vm.nat_interface_id
  ip_configuration_name   = "internal"
  backend_address_pool_id = "${local.app_gateway_id}/backendAddressPools/${var.app_gateway_backend_pool_name}"
}