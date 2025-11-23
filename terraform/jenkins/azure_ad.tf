resource "azuread_group" "jenkins-read" {
  display_name     = "${local.name}-read"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group" "jenkins-executor" {
  display_name     = "${local.name}-executor"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group" "jenkins-developer" {
  display_name     = "${local.name}-developer"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group" "jenkins-admin" {
  display_name     = "${local.name}-admin"
  owners           = data.azuread_users.owners.object_ids
  security_enabled = true
}

resource "azuread_group_member" "owners" {

  for_each = toset(data.azuread_users.owners.object_ids)

  group_object_id  = azuread_group.jenkins-admin.id
  member_object_id = each.key
}