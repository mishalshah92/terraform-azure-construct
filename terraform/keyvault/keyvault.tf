locals {

  subnets = flatten([
    for name, subnet_data in data.azurerm_subnet.allowed_subnet : [
      subnet_data.id
    ]
  ])

  object_ids = concat(data.azuread_users.users.object_ids, data.azuread_groups.groups.object_ids)
}

module "key_vault" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/key-vault?ref=0.3"

  name     = var.name
  location = var.location
  sku_name = var.sku_name

  enabled_vm_for_deployment       = var.enabled_vm_for_deployment
  enabled_for_disk_encryption     = var.enabled_for_disk_encryption
  enabled_for_template_deployment = var.enabled_for_template_deployment
  enable_rbac_authorization       = var.enable_rbac_authorization
  purge_protection_enabled        = var.purge_protection_enabled
  soft_delete_enabled             = var.soft_delete_enabled
  soft_delete_retention_days      = var.soft_delete_retention_days

  network_bypass             = var.network_bypass
  network_default_action     = var.network_default_action
  network_ip_rules           = var.network_ip_rules
  virtual_network_subnet_ids = local.subnets

  contacts = var.contacts

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

resource "azurerm_role_assignment" "iam_access" {

  for_each = toset(local.object_ids)

  scope                = module.key_vault.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = each.key
}