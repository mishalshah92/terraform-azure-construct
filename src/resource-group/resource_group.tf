module "resource-group" {
  source = "git::https://github.com/cloudops92/terraform-azure-modules.git//src/resource-group?ref=add-tag-module"

  name     = var.name
  location = var.location

  tags = module.tags.tags
}