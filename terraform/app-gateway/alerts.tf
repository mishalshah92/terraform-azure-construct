# Ref:
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftcomputevirtualmachinescalesets
# - https://docs.microsoft.com/en-us/azure/azure-monitor/platform/metrics-supported#microsoftnetworkapplicationgateways

locals {
  alert_group_name = "${var.resource_group}_${var.module}_${var.deployment}_${var.location}"
}

resource "azurerm_monitor_action_group" "alert_action_group" {
  name                = local.alert_group_name
  resource_group_name = var.resource_group
  short_name          = "saaiaznotify"

  dynamic "email_receiver" {
    for_each = toset(var.alert_emails)
    content {
      name                    = email_receiver.key
      email_address           = email_receiver.key
      use_common_alert_schema = true
    }
  }

  tags = local.tags
}

# Metric alerts for AppGateway's UnhealthyHostCount

resource "azurerm_monitor_metric_alert" "appgateway_total_time_sev2" {
  name                = "${local.alert_group_name}_total-time_sev2"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's ApplicationGatewayTotalTime - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ApplicationGatewayTotalTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "total_time_sev2", 400)
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "appgateway_total_time_sev1" {
  name                = "${local.alert_group_name}_total-time_sev1"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's ApplicationGatewayTotalTime - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ApplicationGatewayTotalTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "total_time_sev1", 500)
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}


# Metric alerts for AppGateway's UnhealthyHostCount

resource "azurerm_monitor_metric_alert" "appgateway_unhealthy_host_count_sev1" {
  name                = "${local.alert_group_name}_unhealthy-host-count_sev1"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's UnhealthyHostCount - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "UnhealthyHostCount"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "host_count_sev1", 0)
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT5M"

  tags = local.tags
}

# Metric alerts for AppGateway's FailedRequests

resource "azurerm_monitor_metric_alert" "appgateway_failed_requests_sev1" {
  name                = "${local.alert_group_name}_failed-requests_sev1"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's FailedRequests - Sev 1."
  severity    = 1

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "FailedRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "failed_requests_sev1", 15)

    dimension {
      name     = "BackendSettingsPool"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "appgateway_failed_requests_sev2" {
  name                = "${local.alert_group_name}_failed-requests_sev2"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's FailedRequests - Sev 2."
  severity    = 2

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "FailedRequests"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "failed_requests_sev2", 10)

    dimension {
      name     = "BackendSettingsPool"
      operator = "Include"
      values = [
        "*"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for AppGateway's ClientRtt

resource "azurerm_monitor_metric_alert" "appgateway_client_rtt_sev3" {
  name                = "${local.alert_group_name}_client-rtt_sev3"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's ClientRtt - Sev 3."
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "ClientRtt"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "client_rtt_sev3", 500)
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

# Metric alerts for AppGateway's backend response status

resource "azurerm_monitor_metric_alert" "appgateway_backend_response_status_sev3" {
  name                = "${local.alert_group_name}_backend-response-status_sev3"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's BackendResponseStatus - Sev 3."
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "response_status_sev3", 20)

    dimension {
      name     = "BackendPool"
      operator = "Include"
      values = [
        "*"
      ]
    }

    dimension {
      name     = "HttpStatusGroup"
      operator = "Include"
      values = [
        "5xx"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}


resource "azurerm_monitor_metric_alert" "appgateway_backend_response_status_sev2" {
  name                = "${local.alert_group_name}_backend-response-status_sev2"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's BackendResponseStatus - Sev 2."
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "response_status_sev2", 10)

    dimension {
      name     = "BackendPool"
      operator = "Include"
      values = [
        "*"
      ]
    }

    dimension {
      name     = "HttpStatusGroup"
      operator = "Include"
      values = [
        "5xx"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}

resource "azurerm_monitor_metric_alert" "appgateway_backend_response_status_sev4" {
  name                = "${local.alert_group_name}_backend-response-status_sev4"
  resource_group_name = var.resource_group
  scopes = [
    azurerm_application_gateway.app_gateway.id
  ]
  description = "Metric alerts for AppGateway's BackendResponseStatus - Sev 4."
  severity    = 3

  criteria {
    metric_namespace = "Microsoft.Network/applicationGateways"
    metric_name      = "BackendResponseStatus"
    aggregation      = "Total"
    operator         = "GreaterThan"
    threshold        = lookup(var.alert_thresolds, "response_status_sev4", 30)

    dimension {
      name     = "BackendPool"
      operator = "Include"
      values = [
        "*"
      ]
    }

    dimension {
      name     = "HttpStatusGroup"
      operator = "Include"
      values = [
        "4xx"
      ]
    }
  }

  enabled = var.enable_alerts

  action {
    action_group_id = azurerm_monitor_action_group.alert_action_group.id
  }

  action {
    action_group_id = data.azurerm_monitor_action_group.slack_alert_action_group.id
  }

  window_size = "PT15M"

  tags = local.tags
}
