# General
name = "dev"

## Generic Resources
vm_image_name    = "vm_image"
dns_zone         = "dns_zone"
acr_login_server = "acr_login_server"
hub_rg           = "hub_rg"
cert_key_vault   = "keyvault_name"

## Networking
virtual_network_name   = "vnet"
subnet_name            = "subnet"
single_placement_group = false
zone_balance           = false
zones                  = []
private_deploy         = true

## OS
admin_username = "ubuntu"
admin_ssh_keys = {
  "ubuntu" = "ubuntu.pub"
}

## Storage
caching              = "ReadWrite"
storage_account_type = "StandardSSD_LRS"
disk_size_gb         = 30

## AppGateway Networking
app_gateway_sku_name     = "Standard_v2"
app_gateway_sku_tier     = "Standard_v2"
app_gateway_subnet_name  = "gateway-subnet"
app_gateway_nsg_name     = "gateway-subnet-nsg"
app_gateway_enable_http2 = false
app_gateway_min_instance = 1
app_gateway_max_instance = 5
app_gateway_private_ip   = "0.0.0.0"
app_gateway_ssl_policy = [
  {
    policy_type = "Custom"
    #policy_name = "AppGwSslPolicy20170401S"
    min_protocol_version = "TLSv1_2"
    cipher_suites = [
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"
    ]
  }
]

# Service Variables

## ENV
chart_museum_storage_account   = "chartmuseum_storage"
chart_museum_storage_container = "dev"

## Scaling
chart_museum_vm_type             = "Standard_F2"
chart_museum_priority            = "Regular"
chart_museum_min_instances       = 1
chart_museum_max_instances       = 5
chart_museum_scale_in_policy     = "OldestVM"
chart_museum_scale_overprovision = true

## Service config
chart_museum_service_port          = 8080
chart_museum_service_tag           = "latest"
chart_museum_health_check_protocol = "http"
chart_museum_health_check_path     = "/health"

# Alerts
enable_alerts           = false
alert_action_group_name = "alert-group"
alert_emails            = []

# Tags
owner = "Mishal Shah"
email = "mishalshah1992@gmail.com"