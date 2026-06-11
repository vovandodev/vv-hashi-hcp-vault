# HCP Vault Cluster Configuration
# This configuration creates an HCP Vault cluster in HashiCorp Cloud Platform

terraform {
  required_version = ">= 1.0"
  
  required_providers {
    hcp = {
      source  = "hashicorp/hcp"
      version = "~> 0.94"
    }
  }
}

# HCP Provider Configuration
provider "hcp" {
  client_id     = var.hcp_client_id
  client_secret = var.hcp_client_secret
}

# HCP HVN (HashiCorp Virtual Network)
resource "hcp_hvn" "vault_hvn" {
  hvn_id         = var.hvn_id
  cloud_provider = var.cloud_provider
  region         = var.region
  cidr_block     = var.hvn_cidr_block
}

# HCP Vault Cluster
resource "hcp_vault_cluster" "vault_cluster" {
  cluster_id      = var.vault_cluster_id
  hvn_id          = hcp_hvn.vault_hvn.hvn_id
  tier            = var.vault_tier
  public_endpoint = var.public_endpoint
  
  # Optional: Configure audit log streaming
  dynamic "audit_log_config" {
    for_each = var.enable_audit_logs ? [1] : []
    content {
      datadog_api_key = var.datadog_api_key
      datadog_region  = var.datadog_region
    }
  }
  
  # Optional: Configure metrics streaming
  dynamic "metrics_config" {
    for_each = var.enable_metrics ? [1] : []
    content {
      datadog_api_key = var.datadog_api_key
      datadog_region  = var.datadog_region
    }
  }
}

# HCP Vault Cluster Admin Token
resource "hcp_vault_cluster_admin_token" "vault_token" {
  cluster_id = hcp_vault_cluster.vault_cluster.cluster_id
}