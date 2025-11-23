data "azurerm_container_registry" "container_registry" {
  name                = var.acr_login_server
  resource_group_name = var.hub_rg
}

data "azurerm_storage_account" "chartmuseum_storage_account" {
  name                = var.chart_museum_storage_account
  resource_group_name = var.hub_rg
}

data "template_file" "docker_compose" {
  template = file("${path.module}/configs/chart_museum.yml")

  vars = {
    port                        = var.chart_museum_service_port
    tag                         = var.chart_museum_service_tag
    acr_login_server            = var.acr_login_server
    storage_microsoft_container = var.chart_museum_storage_container
    azure_storage_account       = var.chart_museum_storage_account
    azure_storage_access_key    = data.azurerm_storage_account.chartmuseum_storage_account.primary_access_key
  }
}