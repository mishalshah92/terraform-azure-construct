locals {
  name = var.resource_group == var.name ? "${var.resource_group}_slack-notifier" : "${var.resource_group}_slack-notifier_${var.name}"
}

module "logic_app" {
  source = "git::https://github.com/mishah92/terraform-azure-modules.git//src/logic-app-alert-notifier-slack?ref=0.1"

  name     = local.name
  location = var.location

  integration_account_sku_name = "Basic"

  http_request_schema = file("${path.module}/resources/alert_common_schema.json")
  javascript_code     = replace(data.template_file.javascript_code.rendered, "\"", "\\\"")
  slack_webhook_uri   = var.slack_webhook_uri

  customer       = var.customer
  env            = var.env
  owner          = var.owner
  email          = var.email
  repo           = var.repo
  tags           = var.tags
  deployment     = var.deployment
  module         = var.module
  resource_group = var.resource_group
}