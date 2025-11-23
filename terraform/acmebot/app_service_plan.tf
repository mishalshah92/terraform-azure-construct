module "app_service_plan" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/app-service-plan?ref=0.3"

  name     = local.app_service_plan_name
  location = var.location

  kind     = "functionapp"
  sku_tier = "Dynamic"
  sku_size = "Y1"

  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  git_commit     = var.git_commit
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}