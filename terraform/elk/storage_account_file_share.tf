#resource "azurerm_storage_share" "elk_file_share" {
#  name                 = local.name
#  storage_account_name = data.azurerm_storage_account.elasticsearch_storage_account.name
#}

resource "azurerm_storage_share_directory" "configs" {
  name                 = "configs"
  share_name           = data.azurerm_storage_share.elk_file_share.name
  storage_account_name = data.azurerm_storage_account.elasticsearch_storage_account.name
}

resource "local_file" "elasticsearch_instances" {
  content  = data.template_file.elasticsearch_instances.rendered
  filename = "${path.module}/configs/instances_generated.yml"
}

resource "azurerm_storage_share_file" "elasticsearch_instances" {
  name             = "instances.yml"
  storage_share_id = data.azurerm_storage_share.elk_file_share.id
  path             = "configs"
  source           = "${path.module}/configs/instances_generated.yml"
  content_md5      = md5(data.template_file.elasticsearch_instances.rendered)

  depends_on = [
    local_file.elasticsearch_instances,
    azurerm_storage_share_directory.configs
  ]
}