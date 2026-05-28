include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

terraform {
  source = find_in_parent_folders("modules/cloudflare-api-token")
}

inputs = {
  name = basename(get_terragrunt_dir())

  policies = [{
    permission_groups = [{ id = "3030687196b94b638145a3953da2b699" }] # Cloudflare Pages:Edit
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }]
}
