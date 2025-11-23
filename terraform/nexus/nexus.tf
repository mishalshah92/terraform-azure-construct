locals {
  app_gateway_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.resource_group}/providers/Microsoft.Network/applicationGateways/${var.app_gateway_name}"
}

# Virtual machine scale-set

module "service_vmss" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/linux-virtual-machine-scaleset?ref=0.3"

  name                           = "${local.name}_nexus"
  computer_name_prefix           = local.computer_name_prefix
  location                       = var.location
  terminate_notification_timeout = 0

  # Scaling
  number_of_instances    = var.nexus_min_instances
  vm_type                = var.nexus_vm_type
  overprovision          = var.nexus_scale_overprovision
  priority               = var.nexus_priority
  provision_vm_agent     = true
  single_placement_group = var.single_placement_group
  zone_balance           = var.zone_balance
  zones                  = var.zones
  scale_in_policy        = var.nexus_scale_in_policy

  # Networking
  network_interfaces = [
    {
      name    = "${local.name}-vmss-nic"
      primary = true

      ip_configuration = {
        name = "${local.name}-vmss-ip"
        application_gateway_backend_address_pool_ids = [
          "${local.app_gateway_id}/backendAddressPools/${var.app_gateway_backend_pool_name}"
        ]
        primary   = true
        subnet_id = data.azurerm_subnet.app_subnet.id
        version   = "IPv4"
      }
    }
  ]

  # extension
  extensions = [
    {
      name                       = "HealthExtension"
      publisher                  = "Microsoft.ManagedServices"
      type                       = "ApplicationHealthLinux"
      type_handler_version       = "1.0"
      auto_upgrade_minor_version = "true"
      settings = jsonencode({
        "protocol"    = var.nexus_health_check_protocol
        "requestPath" = var.nexus_health_check_request_path
        "port"        = var.nexus_service_port
      })
    }
  ]

  # Identity
  identity_type = "UserAssigned"
  identity_ids = [
    azurerm_user_assigned_identity.nexus_vmss_user_identity.id,
  ]

  # OS
  source_image_id = data.azurerm_image.app_image.id
  admin_username  = var.admin_username
  admin_ssh_keys = [
    {
      username   = var.admin_username
      public_key = data.azurerm_ssh_public_key.ssh_key.public_key
    }
  ]
  base64_encoded_custom_data = module.cloud_init.cloud_init_base64_encoded

  # Disk
  caching              = var.caching
  storage_account_type = var.storage_account_type
  disk_size_gb         = var.disk_size_gb

  # Upgrade
  upgrade_mode = "Manual"

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
    azurerm_user_assigned_identity.nexus_vmss_user_identity,
    azurerm_role_assignment.nexus_vmss_user_identity_key_vault_secrets_user,
  ]

}