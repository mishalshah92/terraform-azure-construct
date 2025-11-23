## Auto-scaling

module "monitor_autoscale_setting" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/monitor-autoscale-setting?ref=0.3"

  name               = "${local.name}_nexus"
  location           = var.location
  target_resource_id = module.service_vmss.id
  enabled            = true

  profile = [
    {
      name = "CPUScaling"

      capacity = {
        default = var.nexus_min_instances
        minimum = var.nexus_min_instances
        maximum = var.nexus_max_instances
      }

      rule = [
        {
          metric_trigger = {
            metric_name        = "Percentage CPU"
            metric_resource_id = module.service_vmss.id
            time_grain         = "PT1M"
            statistic          = "Average"
            time_window        = "PT5M"
            time_aggregation   = "Average"
            operator           = "GreaterThan"
            threshold          = 75
          }

          scale_action = {
            direction = "Increase"
            type      = "ChangeCount"
            value     = "1"
            cooldown  = "PT1M"
          }
        },
        {
          metric_trigger = {
            metric_name        = "Percentage CPU"
            metric_resource_id = module.service_vmss.id
            time_grain         = "PT1M"
            statistic          = "Average"
            time_window        = "PT5M"
            time_aggregation   = "Average"
            operator           = "LessThan"
            threshold          = 25
          }

          scale_action = {
            direction = "Decrease"
            type      = "ChangeCount"
            value     = "1"
            cooldown  = "PT1M"
          }
        }

      ]
    }
  ]

  # Tags
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