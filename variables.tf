# HCP Authentication is handled via environment variables:
# - HCP_CLIENT_ID
# - HCP_CLIENT_SECRET
# Set these in your HCP Terraform workspace as environment variables

# HVN Configuration
variable "hvn_id" {
  description = "The ID of the HashiCorp Virtual Network (HVN)"
  type        = string
  default     = "vault-hvn"
}

variable "cloud_provider" {
  description = "The cloud provider where the HVN will be created (aws or azure)"
  type        = string
  default     = "azure"
  
  validation {
    condition     = contains(["aws", "azure"], var.cloud_provider)
    error_message = "Cloud provider must be either 'aws' or 'azure'."
  }
}

variable "region" {
  description = "The region where the HVN and Vault cluster will be created"
  type        = string
  default     = "westus2"
}

variable "hvn_cidr_block" {
  description = "The CIDR block for the HVN"
  type        = string
  default     = "172.25.16.0/20"
}

# Vault Cluster Configuration
variable "create_vault_cluster" {
  description = "Whether to create the Vault cluster. Set to false to manage HVN independently."
  type        = bool
  default     = true
}

variable "vault_cluster_id" {
  description = "The ID of the HCP Vault cluster"
  type        = string
  default     = "vault-cluster"
}

variable "vault_tier" {
  description = "The tier of the HCP Vault cluster (dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large)"
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
    ], var.vault_tier)
    error_message = "Vault tier must be one of: dev, starter_small, standard_small, standard_medium, standard_large, plus_small, plus_medium, plus_large."
  }
}

variable "public_endpoint" {
  description = "Whether to enable public endpoint for the Vault cluster"
  type        = bool
  default     = true
}

# Optional: Audit Logs Configuration
variable "enable_audit_logs" {
  description = "Enable audit log streaming to Datadog"
  type        = bool
  default     = false
}

# Optional: Metrics Configuration
variable "enable_metrics" {
  description = "Enable metrics streaming to Datadog"
  type        = bool
  default     = false
}

variable "datadog_api_key" {
  description = "Datadog API key for audit logs and metrics (required if enable_audit_logs or enable_metrics is true)"
  type        = string
  default     = ""
  sensitive   = true
}

variable "datadog_region" {
  description = "Datadog region (us1, us3, us5, eu1, ap1)"
  type        = string
  default     = "us1"
  
  validation {
    condition     = contains(["us1", "us3", "us5", "eu1", "ap1"], var.datadog_region)
    error_message = "Datadog region must be one of: us1, us3, us5, eu1, ap1."
  }
}