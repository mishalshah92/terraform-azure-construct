output "id" {
  value = module.aks_nodepool.id
}

output "user_identity_id" {
  value = azurerm_user_assigned_identity.user_identity.id
}

output "user_identity_name" {
  value = azurerm_user_assigned_identity.user_identity.name
}