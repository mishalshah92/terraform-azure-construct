module "resource-group" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/resource-group?ref=0.3"

  name     = var.name
  location = var.location

  tags = module.tags.tags
}