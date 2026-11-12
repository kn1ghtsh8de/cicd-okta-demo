# Authentication is picked up from environment variables, which are set as

# sensitive workspace variables in Terraform Cloud:
#   OKTA_ORG_NAME   e.g. "dev-12345678"
#   OKTA_BASE_URL   e.g. "okta.com"
#   OKTA_API_TOKEN  a token scoped to the demo dev org
#
# Nothing sensitive lives in this repo.
provider "okta" {}
