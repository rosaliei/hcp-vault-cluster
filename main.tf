# https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/hvn
resource "hcp_hvn" "aws_hcp_vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = var.cidr_block
}

# https://registry.terraform.io/providers/hashicorp/hcp/latest/docs/resources/vault_cluster
resource "hcp_vault_cluster" "aws_hcp_vault_cluster" {
  hvn_id          = hcp_hvn.aws_hcp_vault_hvn.hvn_id
  cluster_id      = var.cluster_id
  tier            = var.tier
  public_endpoint = var.public_endpoint
}