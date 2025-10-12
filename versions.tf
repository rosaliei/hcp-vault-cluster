terraform {
  required_version = ">= 1.12"
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.110.0" # Sep 2025 update
    }
  }
}

provider "hcp" {
  # Authentication can be done via environment variables:
  project_id    = var.hcp_project_id    # HCP_PROJECT_ID (optional, if not using organization default)
  client_id     = var.hcp_client_id     # HCP_CLIENT_ID
  client_secret = var.hcp_client_secret # HCP_CLIENT_SECRET
}

