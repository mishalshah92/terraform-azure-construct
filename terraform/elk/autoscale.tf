## Auto-scaling

module "elasticsearch_kibana_monitor_autoscale_setting" {
  source = "git::https://github.com/mishalshah92/terraform-azure-core-modules.git//terraform/monitor-autoscale-setting?ref=0.3"

  name               = "${local.name}_elasticsearch"
  location           = var.location
  target_resource_id = module.elasticsearch_kibana_vm_scaleset.id
  enabled            = true

  profile = [
    {
      name = "FixedScaling"

      capacity = {
        default = var.elasticsearch_kibana_min_instances
        minimum = var.elasticsearch_kibana_min_instances
        maximum = var.elasticsearch_kibana_max_instances
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