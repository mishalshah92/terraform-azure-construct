output "id" {
  value = module.postgresql-db-replica.id
}

output "name" {
  value = local.name
}

output "fqdn" {
  value = module.postgresql-db-replica.fqdn
}

output "identity" {
  value = module.postgresql-db-replica.identity
}