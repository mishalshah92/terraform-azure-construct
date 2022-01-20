output "vnet_name" {
  value = module.vnet.name
}

output "subnets" {
  value = module.subnet
}

output "storage_account_name" {
  value = module.vnet_storage_account.name
}