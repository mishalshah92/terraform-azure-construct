resource "random_password" "grafana_app_client_secret" {
  length  = 32
  special = false
}

resource "azuread_application_password" "ad_app_password" {
  application_object_id = data.azuread_application.grafana.object_id
  value                 = random_password.grafana_app_client_secret.result
  end_date              = timeadd(timestamp(), "13140h")

  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}