variable "ssl_certificates" {
  type    = set(any)
  default = []
}

variable "frontend_ports" {
  type    = list(any)
  default = []
}

variable "http_listeners" {
  type    = list(any)
  default = []
}

variable "backend_address_pools" {
  type    = list(any)
  default = []
}

variable "backend_http_settings" {
  type    = list(any)
  default = []
}

//variable "backend_http_settings" {
//  type = list(object({
//    name                                = string
//    cookie_based_affinity               = string
//    affinity_cookie_name                = string
//    probe_name                          = string
//    request_timeout                     = number
//    port                                = number
//    path                                = string
//    protocol                            = string
//    pick_host_name_from_backend_address = bool
//    host_name                           = string
//    trusted_root_certificate_names      = list(string)
//    authentication_certificate          = list(map(any))
//    connection_draining                 = map(string)
//  }))
//  default = []
//}

variable "request_routing_rules" {
  type    = list(any)
  default = []
}

variable "url_path_maps" {
  type    = list(any)
  default = []
}

variable "redirect_configurations" {
  type    = list(any)
  default = []
}

variable "probes" {
  type    = list(any)
  default = []
}

variable "user_identity_permissions" {
  type    = list(any)
  default = []
}