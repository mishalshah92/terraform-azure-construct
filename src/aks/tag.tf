locals {

  tag_resources = [
    data.azurerm_resources.aks_default_agent_pool_vmss.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_nsg.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_dns-zone.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_public-ip.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_public-ip.resources[1].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[1].id,
    data.azurerm_resources.aks_default_agent_pool_user-assigned-identities.resources[2].id,
    data.azurerm_resources.aks_default_agent_pool_loadBalancers.resources[0].id,
    data.azurerm_resources.aks_default_agent_pool_private-endpoints.resources[0].id
  ]
  nb_resources = length(local.tag_resources)
}

## Tag

module "resource_tagging" {
  source  = "claranet/tagging/azurerm"
  version = "4.0.0"

  nb_resources = local.nb_resources
  resource_ids = local.tag_resources
  behavior     = "merge"

  tags = local.tags
}