terraform {
  required_version = ">= 1.6.0"

  required_providers {
    okta = {
      source  = "okta/okta"
      version = "~> 4.9"
    }
  }

  cloud {
    organization = "cicd-okta-demo"

    workspaces {
      name = "cicd-okta-demo"
    }
  }
}
