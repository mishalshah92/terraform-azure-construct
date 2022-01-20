output "subnets" {
  value = module.subnet.*.name
}

output "network-sg" {
  value = module.network-security-group.*.name
}

output "vnet_name" {
  value = module.vnet.name
}

output "storage_account_name" {
  value = module.vnet_storage_account.name
}