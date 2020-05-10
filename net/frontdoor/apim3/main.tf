resource "azurerm_frontdoor" "frontdoor" {
  name                                         = var.name
  resource_group_name                          = var.resource_group_name

  enforce_backend_pools_certificate_name_check = false

  routing_rule {
    name               = "PrimaryRoutingRules"
    accepted_protocols = [ "Https" ]
    patterns_to_match  = [ "/*" ]
    frontend_endpoints = [ "PrimaryEndpoint" ]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "PrimaryBackend"
    }
  }

  backend_pool_load_balancing {
    name = "baseline"
    additional_latency_milliseconds = 1000
  }

  backend_pool_health_probe {
    name      = "baseline"
    protocol  = "Https"
    path      = var.backend_healthprobe_path
  }

  backend_pool {
    name = "PrimaryBackend"
    backend {
      host_header = var.backend_host_header
      address     = var.backend_fqdn
      http_port   = 80
      https_port  = 443
    }

    load_balancing_name = "baseline"
    health_probe_name   = "baseline"
  }

  frontend_endpoint {
    name                              = "DefaultEndpoint"
    host_name                         = "${var.name}.azurefd.net"
    custom_https_provisioning_enabled = false

  }

  frontend_endpoint {
    name                              = "PrimaryEndpoint"
    host_name                         = var.frontend_hostname
    custom_https_provisioning_enabled = true

    custom_https_configuration {
      certificate_source    = "FrontDoor"
    }
  }

  tags = {
    app = var.app_name
    env = var.env_name
  }

}