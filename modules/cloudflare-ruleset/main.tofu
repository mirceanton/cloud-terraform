terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "5.13.0"
    }
  }
}

resource "cloudflare_ruleset" "this" {
  zone_id     = var.zone_id
  name        = var.ruleset_name
  description = var.ruleset_description
  kind        = "zone"
  phase       = "http_request_dynamic_redirect"

  dynamic "rules" {
    for_each = var.rules
    content {
      action = "redirect"
      action_parameters {
        from_value {
          status_code          = rules.value.status_code
          preserve_query_string = rules.value.preserve_query_string

          target_url {
            value      = rules.value.target_url
            expression = rules.value.target_url_expression
          }
        }
      }
      expression  = rules.value.expression
      description = rules.value.description
      enabled     = rules.value.enabled
    }
  }
}