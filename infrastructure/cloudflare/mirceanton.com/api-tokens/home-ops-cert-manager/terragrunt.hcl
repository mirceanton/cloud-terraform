include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

dependency "zone" { config_path = "../../" }

terraform {
  source = find_in_parent_folders("modules/cloudflare-api-token")
}

inputs = {
  name = basename(get_terragrunt_dir())

  policies = [{
    permission_groups = [{ id = "4755a26eedb94da69e1066d98aa820be" }] # DNS Write
    resources = {
      "com.cloudflare.api.account.zone.${dependency.zone.outputs.zone_id}" = "*"
    }
  }]
}
