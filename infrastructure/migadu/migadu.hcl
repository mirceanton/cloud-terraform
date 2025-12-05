locals {
  domain_name      = "mirceanton.com"
  migadu_api_email = get_env("MIGADU_EMAIL")
  migadu_api_token = get_env("MIGADU_TOKEN")
}