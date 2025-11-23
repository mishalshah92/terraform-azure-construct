module "application_insights" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/application-insights?ref=0.3"

  name             = local.app_insights_name
  location         = var.location
  application_type = "web"

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