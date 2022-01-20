locals {

  user_object_ids = {
    for obj_id in data.azuread_user.azure_user :
    obj_id.user_principal_name => obj_id.object_id
  }

  user_membership_object_ids = {
    for obj_id in data.azuread_user.azure_user_membership :
    obj_id.user_principal_name => obj_id.object_id
  }

  group_object_ids = {
    for obj_id in data.azuread_group.azure_group :
    obj_id.display_name => obj_id.object_id
  }

  group_membership_display_name = flatten([
    for d_name in data.azuread_groups.azure_group_membership : [
      d_name.display_names
    ]
  ])

  group_membership_object_ids = flatten([
    for o_id in data.azuread_groups.azure_group_membership : [
      o_id.object_ids
    ]
  ])
  user_group_membership = zipmap(local.group_membership_display_name, local.group_membership_object_ids)


  object_ids = merge(local.user_object_ids, local.group_object_ids)

  all = merge(var.users, var.groups)

  association_list = flatten([
    for upn, obj_id in local.object_ids : [
      for role, scope in local.all[upn] : [
        for my_scope in scope : {

          obj_id = obj_id
          role   = role
          scope  = replace(var.scope[my_scope], var.aks_cluster_name, data.azurerm_kubernetes_cluster.aks_cluster.id)
        }
      ]
    ]
  ])

  association_map = {
    for objin in local.association_list :
    "${objin["obj_id"]}_${objin["role"]}_${objin["scope"]}" => [objin["obj_id"], objin["role"], objin["scope"]]
  }

  membership_list = flatten([
    for upn, obj_id in local.user_membership_object_ids : [
      for group in var.group_membership[upn] : {
        group_obj_id = local.user_group_membership[group]
        user_obj_id  = obj_id
      }
    ]
  ])
  membership_map = {
    for objin in local.membership_list :
    "${objin["user_obj_id"]}_${objin["group_obj_id"]}" => [objin["user_obj_id"], objin["group_obj_id"]]
  }
}


resource "azurerm_role_assignment" "azure_role_assignment" {
  for_each = local.association_map

  scope                = each.value[2]
  role_definition_name = each.value[1]
  principal_id         = each.value[0]
}

resource "azuread_group_member" "azure_group_member" {
  for_each         = local.membership_map
  group_object_id  = each.value[1]
  member_object_id = each.value[0]
}
