module "linux_vm" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/linux-virtual-machine?ref=1.4"

  name     = var.name
  location = var.location

  # Config
  size                         = var.size
  priority                     = var.priority
  virtual_machine_scale_set_id = var.virtual_machine_scale_set_name == null ? null : data.azurerm_virtual_machine_scale_set.virtual_machine_scale_set.0.id
  proximity_placement_group_id = var.proximity_placement_group_name == null ? null : data.azurerm_proximity_placement_group.placement_group.0.id
  base64_custom_data           = var.base64_custom_data

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
    azurerm_user_assigned_identity.vm_user_identity.id
  ]

  # Storage
  caching                   = var.caching
  storage_account_type      = var.storage_account_type
  disk_size_gb              = var.disk_size_gb
  write_accelerator_enabled = var.write_accelerator_enabled
  disk_encryption_set_id    = var.disk_encryption_set_id

  # Network
  zone                          = var.zone
  enable_ip_forwarding          = var.enable_ip_forwarding
  enable_accelerated_networking = var.enable_accelerated_networking
  subnet_id                     = data.azurerm_subnet.vm_subnet.id
  public_ip_address_id          = var.public_ip ? azurerm_public_ip.public_ip.0.id : null
  primary_ip_config             = var.primary_ip_config

  # Source Image
  source_image_id = var.source_image_name == null ? null : data.azurerm_image.source_image[0].id

  source_image_reference = var.source_image_name == null ? [
    {
      source_image_publisher = var.source_image_publisher
      source_image_offer     = var.source_image_offer
      source_image_sku       = var.source_image_sku
      source_image_version   = var.source_image_version
    }
  ] : []

  auto_shutdown_enabled  = var.auto_shutdown_enabled
  auto_shutdown_time     = var.auto_shutdown_time
  auto_shutdown_timezone = var.auto_shutdown_timezone

  # Secret
  secret = var.secret

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
    azurerm_user_assigned_identity.vm_user_identity
  ]
}
