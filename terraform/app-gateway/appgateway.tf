locals {
  gateway_ip_configuration_name = "GatewayIpConfig"

  # Frontend IP Configurations
  frontend_private_ip_configuration_name = "private"
  frontend_public_ip_configuration_name  = "public"
}

# AppGateway

resource "azurerm_application_gateway" "app_gateway" {

  name                = local.name
  resource_group_name = var.resource_group
  location            = var.location

  ## Configs
  enable_http2 = var.enable_http2
  sku {
    name = var.sku_name
    tier = var.sku_tier
  }

  autoscale_configuration {
    min_capacity = var.min_instance
    max_capacity = var.max_instance
  }

  ## Networking
  zones = var.zones

  gateway_ip_configuration {
    name      = local.gateway_ip_configuration_name
    subnet_id = data.azurerm_subnet.app_gateway_subnet.id
  }

  ssl_policy {
    policy_type          = "Custom"
    min_protocol_version = "TLSv1_2"
    cipher_suites = [
      "TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384",
      "TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256",
      "TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA"
    ]
  }

  dynamic "ssl_certificate" {
    for_each = data.azurerm_key_vault_secret.keyvault_cert_secret
    content {
      name                = ssl_certificate.key
      key_vault_secret_id = ssl_certificate.value.id
    }
  }

  ### Frontend IP configurations
  frontend_ip_configuration {
    name                          = local.frontend_private_ip_configuration_name
    subnet_id                     = data.azurerm_subnet.app_gateway_subnet.id
    private_ip_address            = var.private_ip
    private_ip_address_allocation = "Static"
  }

  frontend_ip_configuration {
    name                 = local.frontend_public_ip_configuration_name
    public_ip_address_id = azurerm_public_ip.app_gateway_public_ip.id
  }

  dynamic "frontend_port" {
    for_each = var.frontend_ports
    content {
      name = frontend_port.value.name
      port = frontend_port.value.port
    }
  }

  dynamic "backend_address_pool" {
    for_each = var.backend_address_pools
    content {
      name = backend_address_pool.value.name
    }
  }

  dynamic "backend_http_settings" {
    for_each = var.backend_http_settings
    content {
      name                                = backend_http_settings.value.name
      cookie_based_affinity               = lookup(backend_http_settings.value, "cookie_based_affinity", "Disabled")
      affinity_cookie_name                = lookup(backend_http_settings.value, "affinity_cookie_name", null)
      probe_name                          = lookup(backend_http_settings.value, "probe_name", null)
      request_timeout                     = lookup(backend_http_settings.value, "request_timeout", 5)
      port                                = lookup(backend_http_settings.value, "port", 80)
      path                                = lookup(backend_http_settings.value, "path", null)
      protocol                            = lookup(backend_http_settings.value, "protocol", "Http")
      pick_host_name_from_backend_address = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", false)
      host_name                           = lookup(backend_http_settings.value, "pick_host_name_from_backend_address", true) == true ? null : lookup(backend_http_settings.value, "host_name", null)

      dynamic "connection_draining" {
        for_each = lookup(backend_http_settings.value, "connection_draining", [])
        content {
          drain_timeout_sec = connection_draining.value.drain_timeout_sec
          enabled           = connection_draining.value.enabled
        }
      }
    }
  }

  dynamic "http_listener" {
    for_each = var.http_listeners
    content {
      name                           = http_listener.value.name
      frontend_ip_configuration_name = http_listener.value.frontend_ip_configuration_name
      frontend_port_name             = http_listener.value.frontend_port_name
      protocol                       = http_listener.value.protocol
      host_name                      = lookup(http_listener.value, "host_name", null)
      host_names                     = lookup(http_listener.value, "host_names", null) == null ? [] : http_listener.value.host_names
      require_sni                    = lookup(http_listener.value, "require_sni", null)
      ssl_certificate_name           = lookup(http_listener.value, "ssl_certificate_name", null)
      firewall_policy_id             = lookup(http_listener.value, "firewall_policy_id", null)
    }
  }

  dynamic "request_routing_rule" {
    for_each = var.request_routing_rules
    content {
      http_listener_name          = request_routing_rule.value.http_listener_name
      name                        = request_routing_rule.value.name
      rule_type                   = request_routing_rule.value.rule_type
      backend_address_pool_name   = lookup(request_routing_rule.value, "backend_address_pool_name", null)
      backend_http_settings_name  = lookup(request_routing_rule.value, "backend_http_settings_name", null)
      redirect_configuration_name = lookup(request_routing_rule.value, "redirect_configuration_name", null)
      rewrite_rule_set_name       = lookup(request_routing_rule.value, "rewrite_rule_set_name", null)
      url_path_map_name           = lookup(request_routing_rule.value, "url_path_map_name", null)
    }
  }

  dynamic "probe" {
    for_each = var.probes
    content {
      host                                      = lookup(probe.value, "pick_host_name_from_backend_http_settings", false) == true ? null : lookup(probe.value, "host", null)
      interval                                  = probe.value.interval
      name                                      = probe.value.name
      path                                      = probe.value.path
      protocol                                  = probe.value.protocol
      timeout                                   = probe.value.timeout
      unhealthy_threshold                       = probe.value.unhealthy_threshold
      pick_host_name_from_backend_http_settings = lookup(probe.value, "pick_host_name_from_backend_http_settings", false)
      minimum_servers                           = probe.value.minimum_servers

      dynamic "match" {
        for_each = lookup(probe.value, "match", [])
        content {
          body        = lookup(match.value, "body", null)
          status_code = lookup(match.value, "status_code", null)
        }
      }
    }
  }

  dynamic "url_path_map" {
    for_each = var.url_path_maps
    content {
      name                                = url_path_map.value.name
      default_backend_address_pool_name   = lookup(url_path_map.value, "default_backend_address_pool_name", null)
      default_backend_http_settings_name  = lookup(url_path_map.value, "default_backend_http_settings_name", null)
      default_redirect_configuration_name = lookup(url_path_map.value, "default_redirect_configuration_name", null)
      default_rewrite_rule_set_name       = lookup(url_path_map.value, "default_rewrite_rule_set_name", null)
      dynamic "path_rule" {
        for_each = url_path_map.value.path_rule
        content {
          name                        = path_rule.value.name
          paths                       = path_rule.value.paths
          backend_address_pool_name   = lookup(path_rule.value, "backend_address_pool_name", null)
          backend_http_settings_name  = lookup(path_rule.value, "backend_http_settings_name", null)
          redirect_configuration_name = lookup(path_rule.value, "redirect_configuration_name", null)
          rewrite_rule_set_name       = lookup(path_rule.value, "rewrite_rule_set_name", null)
        }
      }
    }
  }

  dynamic "redirect_configuration" {
    for_each = var.redirect_configurations
    content {
      name                 = redirect_configuration.value.name
      redirect_type        = redirect_configuration.value.redirect_type
      target_listener_name = lookup(redirect_configuration.value, "target_listener_name", null)
      target_url           = lookup(redirect_configuration.value, "target_url", null)
      include_path         = lookup(redirect_configuration.value, "include_path", null)
      include_query_string = lookup(redirect_configuration.value, "include_query_string", null)
    }
  }

  # Identity
  identity {
    identity_ids = [
      azurerm_user_assigned_identity.app_gateway_user_identity.id,
    ]
  }

  tags = local.tags

}