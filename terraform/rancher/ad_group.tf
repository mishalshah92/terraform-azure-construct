resource "azuread_group" "rancher_read" {
  display_name     = "${local.name}-read"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group" "rancher_developer" {
  display_name     = "${local.name}-developer"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group" "rancher_admin" {
  display_name     = "${local.name}-admin"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group_member" "owners" {

  for_each = toset(data.azuread_users.owners.object_ids)

  group_object_id  = azuread_group.rancher_admin.id
  member_object_id = each.key
}