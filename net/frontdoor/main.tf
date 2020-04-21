resource "azurerm_frontdoor" "frontdoor" {
  name                                         = var.name
  resource_group_name                          = var.resource_group_name

  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "PrimaryRoutingRules"
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["PrimaryEndpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "PrimaryBackend"
    }
  }

  backend_pool_load_balancing {
    name = "baseline"
  }

  backend_pool_health_probe {
    name = "baseline"
  }

  backend_pool {
    name = "PrimaryBackend"
    backend {
      host_header = var.backend_hostname
      address     = var.backend_hostname
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "baseline"
    health_probe_name   = "baseline"
  }

  frontend_endpoint {
    name                              = "PrimaryEndpoint"
    host_name                         = var.frotnend_hostname
    custom_https_provisioning_enabled = false
  }
}