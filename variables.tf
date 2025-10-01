######################################################
# HCP Provider Variables
######################################################

variable "hcp_project_id" {
  description = "hcp project id"
  type        = string
  default     = ""
}

variable "hcp_client_id" {
  description = "hcp client id"
  type        = string
  default     = ""
}

variable "hcp_client_secret" {
  description = "hcp client secret"
  type        = string
  default     = ""
}

######################################################
# HCP HVN Variables
######################################################

variable "hvn_id" {
  description = "The ID of the HCP HVN"
  type        = string
  default     = "main-hvn"
}

variable "cloud_provider" {
  description = "The cloud provider for the HCP HVN"
  type        = string
  default     = "aws"
  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Cloud provider must be either 'aws' or 'azure'."
  }
}

variable "region" {
  description = "The region for the HCP HVN"
  type        = string
  default     = "ap-southeast-1"
}

variable "cidr_block" {
  description = "The CIDR block for the HCP HVN"
  type        = string
  default     = "172.25.16.0/20"
}

######################################################
# HCP Vault Cluster Variables
######################################################

variable "cluster_id" {
  description = "The ID of the HCP Vault cluster"
  type        = string
  default     = "aws-hcp-vault-cluster"
}

variable "tier" {
  description = "Tier of the HCP Vault cluster. Valid options for tiers"
  type        = string
  default     = "dev"
  validation {
    condition = contains([
      "dev",
      "starter_small",
      "standard_small",
      "standard_medium",
      "standard_large",
      "plus_small",
      "plus_medium",
      "plus_large"
    ], var.tier)
    error_message = "Tier must be one of: dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large."
  }
}

variable "public_endpoint" {
  description = "Whether to enable public endpoint for the Vault cluster"
  type        = bool
  default     = true
}