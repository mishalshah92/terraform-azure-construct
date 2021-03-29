data "template_file" "javascript_code" {
  template = file("${path.module}/resources/alert_slack_formatter.js")
  vars = {
    slack_channel_id = var.slack_channel_id
    slack_username   = var.slack_username
  }
}

data "template_file" "javascript_code_minify" {
  template = file("${path.module}/resources/alert_slack_formatter_minify.js")
  vars = {
    slack_channel_id = var.slack_channel_id
    slack_username   = var.slack_username
  }
}