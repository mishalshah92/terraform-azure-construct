locals {

  subnets = flatten([
    for name, subnet_data in data.azurerm_subnet.allowed_subnet : [
      subnet_data.id
    ]
  ])
}


module "key_vault" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//terraform/key-vault?ref=0.5"

  name     = local.key_vault_name
  location = var.location
  sku_name = "standard"

  enabled_vm_for_deployment       = true
  enabled_for_disk_encryption     = true
  enabled_for_template_deployment = false
  enable_rbac_authorization       = false
  purge_protection_enabled        = false
  soft_delete_enabled             = true
  soft_delete_retention_days      = 10

  # Network ACLs
  network_bypass             = "AzureServices"
  network_default_action     = var.keyvault_network_default_action
  network_ip_rules           = var.keyvault_network_default_action == "Allow" ? null : (var.keyvault_network_ip_rules == null ? [data.http.myip.body] : concat([data.http.myip.body], var.keyvault_network_ip_rules))
  virtual_network_subnet_ids = var.keyvault_network_default_action == "Allow" ? null : local.subnets

  contacts = var.keyvault_notification_contacts

  # Tags
  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  git_commit     = var.git_commit
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}

resource "azurerm_key_vault_access_policy" "allowed_user_access" {

  for_each = toset(data.azuread_users.keyvault_admins.object_ids)

  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.key

  certificate_permissions = [
    "backup",
    "create",
    "delete",
    "deleteissuers",
    "get",
    "getissuers",
    "import",
    "list",
    "listissuers",
    "managecontacts",
    "manageissuers",
    "purge",
    "recover",
    "restore",
    "setissuers",
    "update"
  ]

  key_permissions = [
    "backup",
    "create",
    "decrypt",
    "delete",
    "encrypt",
    "get",
    "import",
    "list",
    "purge",
    "recover",
    "restore",
    "sign",
    "unwrapKey",
    "update",
    "verify",
    "wrapKey"
  ]

  secret_permissions = [
    "get",
    "backup",
    "delete",
    "get",
    "list",
    "purge",
    "recover",
    "restore",
    "set"
  ]

  storage_permissions = [
    "backup",
    "delete",
    "deletesas",
    "get", "getsas",
    "list",
    "listsas",
    "purge",
    "recover",
    "regeneratekey",
    "restore",
    "set",
    "setsas",
    "update"
  ]
}


resource "azurerm_key_vault_access_policy" "allowed_function_app" {

  key_vault_id = module.key_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = module.function_app.identity.0.principal_id

  certificate_permissions = [
    "get",
    "list",
    "update",
    "create",
    "import",
    "delete",
    "recover",
    "backup",
    "restore",
    "managecontacts",
    "deleteissuers",
    "getissuers",
    "listissuers",
    "manageissuers",
    "setissuers",
  ]
}