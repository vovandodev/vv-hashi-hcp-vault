# HVN Outputs
output "hvn_id" {
  description = "The ID of the HashiCorp Virtual Network"
  value       = hcp_hvn.vault_hvn.hvn_id
}

output "hvn_self_link" {
  description = "The self link of the HVN"
  value       = hcp_hvn.vault_hvn.self_link
}

output "hvn_cidr_block" {
  description = "The CIDR block of the HVN"
  value       = hcp_hvn.vault_hvn.cidr_block
}

output "hvn_region" {
  description = "The region where the HVN is created"
  value       = hcp_hvn.vault_hvn.region
}

output "hvn_cloud_provider" {
  description = "The cloud provider of the HVN"
  value       = hcp_hvn.vault_hvn.cloud_provider
}

# Vault Cluster Outputs
output "vault_cluster_id" {
  description = "The ID of the HCP Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.cluster_id
}

output "vault_public_endpoint_url" {
  description = "The public URL of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
}

output "vault_private_endpoint_url" {
  description = "The private URL of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.vault_private_endpoint_url
}

output "vault_version" {
  description = "The version of Vault running on the cluster"
  value       = hcp_vault_cluster.vault_cluster.vault_version
}

output "vault_tier" {
  description = "The tier of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.tier
}

output "vault_namespace" {
  description = "The namespace of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.namespace
}

output "vault_organization_id" {
  description = "The organization ID of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.organization_id
}

output "vault_project_id" {
  description = "The project ID of the Vault cluster"
  value       = hcp_vault_cluster.vault_cluster.project_id
}

# Admin Token Output
output "vault_admin_token" {
  description = "The admin token for the Vault cluster (sensitive)"
  value       = hcp_vault_cluster_admin_token.vault_token.token
  sensitive   = true
}

# Connection Information
output "vault_connection_info" {
  description = "Connection information for the Vault cluster"
  value = {
    public_url  = hcp_vault_cluster.vault_cluster.vault_public_endpoint_url
    private_url = hcp_vault_cluster.vault_cluster.vault_private_endpoint_url
    namespace   = hcp_vault_cluster.vault_cluster.namespace
  }
}