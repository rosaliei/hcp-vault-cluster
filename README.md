# HashiCorp Cloud Platform (HCP) Vault Implementation

## Executive Summary

This Terraform configuration provisions a production-ready HashiCorp Vault cluster on HashiCorp Cloud Platform (HCP), designed to meet enterprise security and compliance requirements. The implementation follows HashiCorp's Well-Architected Framework principles and industry best practices for secrets management infrastructure.

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                    HashiCorp Cloud Platform                 │
│  ┌─────────────────────────────────────────────────────────┐│
│  │                HCP Virtual Network (HVN)               ││
│  │                172.25.16.0/20                          ││
│  │  ┌───────────────────────────────────────────────────┐ ││
│  │  │              HCP Vault Cluster                    │ ││
│  │  │                                                   │ ││
│  │  │  • Managed Control Plane                         │ ││
│  │  │  • Automated Backups                             │ ││
│  │  │  • Built-in Monitoring                           │ ││
│  │  │  • Enterprise Features                           │ ││
│  │  └───────────────────────────────────────────────────┘ ││
│  └─────────────────────────────────────────────────────────┘│
└─────────────────────────────────────────────────────────────┘
              │
              │ API/UI Access
              │
    ┌─────────▼─────────┐
    │   Client Access   │
    │                   │
    │ • Vault CLI       │
    │ • REST API        │
    │ • Web UI          │
    │ • Applications    │
    └───────────────────┘
```

## Solution Components

### Core Infrastructure
- **HCP Virtual Network (HVN)**: Dedicated network boundary for Vault cluster
- **HCP Vault Cluster**: Fully managed Vault service with enterprise capabilities
- **Network Security**: Configurable public/private endpoint access

### Key Features
- ✅ **Zero-Touch Operations**: Fully managed by HashiCorp
- ✅ **Enterprise Ready**: Built-in compliance and security features  
- ✅ **High Availability**: Multi-AZ deployment with automated failover
- ✅ **Automated Backups**: Point-in-time recovery capabilities
- ✅ **Integrated Monitoring**: Native observability and alerting
- ✅ **Scalable Tiers**: Right-sized compute and storage options

## Prerequisites

### Required Tools
| Tool | Version | Purpose |
|------|---------|---------|
| Terraform | >= 1.12 | Infrastructure provisioning |
| HCP CLI | Latest | Optional: Cluster management |

### HCP Account Requirements
1. **HCP Organization**: Active HashiCorp Cloud Platform account
2. **Service Principal**: Programmatic access credentials
3. **Project Access**: Contributor or Admin role assignment
4. **Billing**: Valid payment method for resource consumption

### Service Principal Setup
```bash
# Create service principal via HCP Console
# Navigate: HCP Console → Access Control (IAM) → Service Principals

# Required permissions:
# Contributor or Admin
```

## Configuration Management

### Environment Variables
```bash
# Required for authentication
export HCP_CLIENT_ID="your-service-principal-client-id"
export HCP_CLIENT_SECRET="your-service-principal-client-secret"
export HCP_PROJECT_ID="your-project-id"

# Optional: Override default configuration
export TF_VAR_cluster_id="production-vault"
export TF_VAR_tier="standard_small"
```

### Terraform Variables

#### Core Configuration
| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `hcp_project_id` | string | "" | HCP Project identifier |
| `hcp_client_id` | string | "" | Service principal client ID |
| `hcp_client_secret` | string | "" | Service principal secret |

#### Network Configuration
| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `hvn_id` | string | "main-hvn" | HVN identifier |
| `cloud_provider` | string | "aws" | Target cloud provider |
| `region` | string | "ap-southeast-1" | Deployment region |
| `cidr_block` | string | "172.25.16.0/20" | HVN network range |

#### Vault Cluster Configuration
| Variable | Type | Default | Description |
|----------|------|---------|-------------|
| `cluster_id` | string | "aws-hcp-vault-cluster" | Vault cluster identifier |
| `tier` | string | "dev" | Cluster performance tier |
| `public_endpoint` | bool | true | Enable public API access |

### Tier Selection Guide

* HCP Vault Dedicated tiers and features(https://developer.hashicorp.com/hcp/docs/vault/get-started/deployment-considerations/tiers-and-features)


## Deployment Procedures

### Initial Deployment
```bash
# 1. Clone and navigate to project
cd hcp-aws-vault-dedicated-cluster

# 2. Initialize Terraform
terraform init

# 3. Create configuration file
cp terraform.tfvars.example terraform.tfvars

# 4. Customize deployment parameters
vim terraform.tfvars

# 5. Validate configuration
terraform validate
terraform fmt

# 6. Review planned changes
terraform plan

# 7. Deploy infrastructure
terraform apply
```

### Post-Deployment Verification
```bash
# Retrieve cluster information
terraform output vault_cli_commands

# Verify cluster accessibility
export VAULT_ADDR=$(terraform output -raw vault_public_endpoint_url)
export VAULT_NAMESPACE=$(terraform output -raw vault_namespace)
vault status
```
---
**Document Version**: 1.0  
**Last Updated**: September 2025  
**Next Review**: December 2025
