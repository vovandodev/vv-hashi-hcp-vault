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
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].cluster_id : null
}

output "vault_public_endpoint_url" {
  description = "The public URL of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].vault_public_endpoint_url : null
}

output "vault_private_endpoint_url" {
  description = "The private URL of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].vault_private_endpoint_url : null
}

output "vault_version" {
  description = "The version of Vault running on the cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].vault_version : null
}

output "vault_tier" {
  description = "The tier of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].tier : null
}

output "vault_namespace" {
  description = "The namespace of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].namespace : null
}

output "vault_organization_id" {
  description = "The organization ID of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].organization_id : null
}

output "vault_project_id" {
  description = "The project ID of the Vault cluster"
  value       = var.create_vault_cluster ? hcp_vault_cluster.vault_cluster[0].project_id : null
}

# Connection Information
output "vault_connection_info" {
  description = "Connection information for the Vault cluster"
  value = var.create_vault_cluster ? {
    public_url  = hcp_vault_cluster.vault_cluster[0].vault_public_endpoint_url
    private_url = hcp_vault_cluster.vault_cluster[0].vault_private_endpoint_url
    namespace   = hcp_vault_cluster.vault_cluster[0].namespace
  } : null
}