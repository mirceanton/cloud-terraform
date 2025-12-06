include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

# Pull zone_id from parent zone unit
dependency "zone" { config_path = "../" }

terraform {
  source = find_in_parent_folders("modules/cloudflare-ruleset")
}

inputs = {
  zone_id = dependency.zone.outputs.zone_id
  ruleset_name        = "Redirect rules"
  ruleset_description = "Zone redirect rules"

  rules = {
    redirect_secondary_domain = {
      description           = "Redirect secondary domain to main one"
      expression            = "(http.host eq \"${dependency.zone.outputs.zone_name}\") or (http.host eq \"www.${dependency.zone.outputs.zone_name}\")"
      status_code           = 301
      preserve_query_string = true
      target_url_expression = "concat(\"https://mirceanton.com\", http.request.uri.path)"
    }
  }
}