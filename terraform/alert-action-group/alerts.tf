# Ref:
# Alert Action Groups

resource "azurerm_monitor_action_group" "alert_action_group" {
  name                = "${var.resource_group}_${var.location}_${var.name}"
  resource_group_name = var.resource_group
  short_name          = "saaiaznotify"

  email_receiver {
    name                    = "ResourceAdmin"
    email_address           = var.email
    use_common_alert_schema = true
  }

  dynamic "email_receiver" {
    for_each = toset(var.alert_emails)
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.key
      use_common_alert_schema = true
    }
  }

  logic_app_receiver {
    name                    = var.slack_notifier_logic_app_name
    callback_url            = var.slack_notifier_logic_app_endpoint
    resource_id             = data.azurerm_logic_app_workflow.slack_notifier_logic_app.id
    use_common_alert_schema = true
  }

  dynamic "logic_app_receiver" {
    for_each = var.alert_logic_app
    content {
      name                    = logic_app_receiver.value.name
      resource_id             = var.resource_group
      callback_url            = logic_app_receiver.value.callback_url
      use_common_alert_schema = logic_app_receiver.value.use_common_alert_schema
    }
  }

  tags = local.tags
}
