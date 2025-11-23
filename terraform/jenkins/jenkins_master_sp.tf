resource "azuread_application_password" "ad_app_password" {
  application_object_id = data.azuread_application.jenkins_master.object_id
  display_name          = "Jenkins Master Azure AD Secret"
  end_date_relative     = "13140h"

  lifecycle {
    ignore_changes = [
      end_date
    ]
  }
}