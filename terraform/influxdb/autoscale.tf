## Auto-scaling

module "sonarqube_monitor_autoscale_setting" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/monitor-autoscale-setting?ref=0.3"

  name               = "${local.name}_jenkins-master"
  location           = var.location
  target_resource_id = module.service_vmss.id
  enabled            = true

  profile = [
    {
      name = "FixedScaling"

      capacity = {
        default = var.influxdb_min_instances
        minimum = var.influxdb_min_instances
        maximum = var.influxdb_max_instances
      }

      rule = []
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