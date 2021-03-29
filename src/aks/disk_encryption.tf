resource "azurerm_key_vault_key" "disk_encryption_key" {
  name         = "aks-${var.name}"
  key_vault_id = data.azurerm_key_vault.rg_keyvault.id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]

  tags = local.tags
}

resource "azurerm_disk_encryption_set" "disk_encryption_set" {
  name                = "aks_${var.name}"
  resource_group_name = var.resource_group
  location            = var.location
  key_vault_key_id    = azurerm_key_vault_key.disk_encryption_key.id

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "disk_encryption_set_keyvault_crypto_user" {
  scope                = data.azurerm_key_vault.rg_keyvault.id
  role_definition_name = "Key Vault Crypto Service Encryption User"
  principal_id         = azurerm_disk_encryption_set.disk_encryption_set.identity[0].principal_id
}