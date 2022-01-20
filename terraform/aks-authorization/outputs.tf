output "id" {
  value = [for rid in azurerm_role_assignment.azure_role_assignment : rid.id]
}