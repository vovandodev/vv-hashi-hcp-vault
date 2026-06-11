# HCP Vault Terraform Configuration

This Terraform configuration creates a HashiCorp Cloud Platform (HCP) Vault cluster with all necessary infrastructure, designed to run in HCP Terraform (Terraform Cloud).

## Prerequisites

1. **HCP Account**: Sign up at [HashiCorp Cloud Platform](https://portal.cloud.hashicorp.com/)
2. **HCP Terraform Account**: Sign up at [HCP Terraform](https://app.terraform.io/)
3. **HCP Service Principal**: Create a service principal with appropriate permissions

## What This Creates

- **HCP HVN (HashiCorp Virtual Network)**: A dedicated network for your HCP resources
- **HCP Vault Cluster**: A managed Vault cluster in your chosen tier
- **Admin Token**: An admin token for initial Vault access

## Setup in HCP Terraform

### 1. Create HCP Service Principal

1. Log in to [HCP Portal](https://portal.cloud.hashicorp.com/)
2. Navigate to **Settings** → **Service Principals**
3. Click **Create Service Principal**
4. Give it a name (e.g., "terraform-vault")
5. Assign the **Contributor** role
6. Save the **Client ID** and **Client Secret**

### 2. Create HCP Terraform Workspace

1. Log in to [HCP Terraform](https://app.terraform.io/)
2. Create a new workspace
3. Choose **Version Control Workflow**
4. Connect your Git repository containing this code
5. Configure the workspace settings

### 3. Configure Workspace Variables

In your HCP Terraform workspace, add the following variables:

#### Environment Variables (Sensitive)
- `HCP_CLIENT_ID` = your-hcp-client-id (mark as sensitive)
- `HCP_CLIENT_SECRET` = your-hcp-client-secret (mark as sensitive)

#### Terraform Variables
Configure these in the workspace variables section:

| Variable | Description | Example | Required |
|----------|-------------|---------|----------|
| `hcp_client_id` | HCP Service Principal Client ID | (use env var) | Yes |
| `hcp_client_secret` | HCP Service Principal Secret | (use env var) | Yes |
| `hvn_id` | HVN identifier | `vault-hvn` | No (has default) |
| `cloud_provider` | Cloud provider (aws/azure) | `aws` | No (has default) |
| `region` | Cloud region | `us-west-2` | No (has default) |
| `hvn_cidr_block` | HVN CIDR block | `172.25.16.0/20` | No (has default) |
| `vault_cluster_id` | Vault cluster identifier | `vault-cluster` | No (has default) |
| `vault_tier` | Vault tier | `dev` | No (has default) |
| `public_endpoint` | Enable public endpoint | `true` | No (has default) |

**Note**: You can reference environment variables in Terraform variables using `var.hcp_client_id` which will use the `HCP_CLIENT_ID` environment variable.

### 4. Trigger Deployment

1. Commit and push this code to your Git repository
2. HCP Terraform will automatically trigger a plan
3. Review the plan in the HCP Terraform UI
4. Approve and apply the changes

## Configuration Options

### Vault Tiers

Choose the appropriate tier based on your needs:

- **`dev`**: Development/testing (not for production)
- **`starter_small`**: Small production workloads
- **`standard_small/medium/large`**: Standard production tiers
- **`plus_small/medium/large`**: Enhanced performance tiers

### Cloud Providers

Supported cloud providers:
- **`aws`**: Amazon Web Services
- **`azure`**: Microsoft Azure

### Regions

Common AWS regions:
- `us-west-2` (Oregon)
- `us-east-1` (N. Virginia)
- `eu-west-1` (Ireland)
- `ap-southeast-1` (Singapore)

Common Azure regions:
- `eastus`
- `westus2`
- `westeurope`
- `southeastasia`

## Accessing Your Vault Cluster

After successful deployment, view the outputs in your HCP Terraform workspace:

### Available Outputs

| Output | Description |
|--------|-------------|
| `vault_public_endpoint_url` | Public URL for Vault access |
| `vault_private_endpoint_url` | Private URL for VPC access |
| `vault_admin_token` | Admin token (sensitive) |
| `vault_cluster_id` | Cluster identifier |
| `vault_version` | Vault version running |
| `hvn_id` | HVN identifier |
| `hvn_cidr_block` | HVN CIDR block |

### Connect to Vault

Using the outputs from HCP Terraform:

```bash
# Set environment variables (get values from HCP Terraform outputs)
export VAULT_ADDR="<vault_public_endpoint_url>"
export VAULT_TOKEN="<vault_admin_token>"
export VAULT_NAMESPACE="<vault_namespace>"

# Verify connection
vault status
```

## Optional Features

### Audit Logs and Metrics (Datadog)

To enable audit log and metrics streaming to Datadog, add these workspace variables:

| Variable | Value | Sensitive |
|----------|-------|-----------|
| `enable_audit_logs` | `true` | No |
| `enable_metrics` | `true` | No |
| `datadog_api_key` | Your Datadog API key | Yes |
| `datadog_region` | `us1` (or us3, us5, eu1, ap1) | No |

## HCP Terraform Best Practices

### Variable Management

1. **Use Environment Variables** for sensitive credentials (HCP_CLIENT_ID, HCP_CLIENT_SECRET)
2. **Use Terraform Variables** for configuration values
3. **Mark sensitive variables** appropriately in the workspace
4. **Use Variable Sets** to share common variables across workspaces

### Workspace Configuration

1. **Enable Auto Apply** for automated deployments (optional)
2. **Configure VCS Triggers** to control when runs occur
3. **Set up Notifications** for run status updates
4. **Use Run Triggers** to coordinate with other workspaces

### State Management

- HCP Terraform automatically manages state
- State is encrypted at rest and in transit
- State locking is handled automatically
- No need to configure backend - it's built-in

## Security Best Practices

1. **Never commit credentials** - Use HCP Terraform environment variables
2. **Rotate admin tokens** - Create new tokens and revoke old ones regularly
3. **Use private endpoints** - For production, consider using private endpoints only
4. **Enable audit logs** - Track all Vault operations
5. **Implement least privilege** - Create specific tokens/policies for applications
6. **Use Sentinel policies** - Enforce governance in HCP Terraform (if available)

## Cost Considerations

- **Dev tier**: Lowest cost, suitable for development only
- **Production tiers**: Billed hourly based on tier size
- **Data transfer**: Additional charges may apply for data egress
- Check [HCP Pricing](https://cloud.hashicorp.com/pricing) for current rates

## Cleanup

To destroy all resources:

1. Go to your HCP Terraform workspace
2. Navigate to **Settings** → **Destruction and Deletion**
3. Queue a destroy plan
4. Review and confirm the destruction

**Warning**: This will permanently delete your Vault cluster and all data!

## Troubleshooting

### Authentication Issues

Verify your HCP credentials are correctly set as environment variables in the workspace:
- `HCP_CLIENT_ID`
- `HCP_CLIENT_SECRET`

### Plan Failures

1. Check the run logs in HCP Terraform UI
2. Verify all required variables are set
3. Ensure your service principal has appropriate permissions

### State Issues

HCP Terraform handles state automatically. If you encounter issues:
1. Check workspace settings
2. Review state versions in the UI
3. Contact HCP Terraform support if needed

## Repository Structure

```
.
├── main.tf                      # Main Terraform configuration
├── variables.tf                 # Variable definitions
├── outputs.tf                   # Output definitions
├── terraform.tfvars.example     # Example variable values (for reference)
├── .gitignore                   # Git ignore rules
└── README.md                    # This file
```

## Additional Resources

- [HCP Vault Documentation](https://developer.hashicorp.com/hcp/docs/vault)
- [HCP Terraform Documentation](https://developer.hashicorp.com/terraform/cloud-docs)
- [Terraform HCP Provider](https://registry.terraform.io/providers/hashicorp/hcp/latest/docs)
- [Vault Documentation](https://developer.hashicorp.com/vault/docs)
- [HCP Portal](https://portal.cloud.hashicorp.com/)

## Support

For issues with:
- **Terraform configuration**: Open an issue in this repository
- **HCP Terraform**: Contact [HCP Support](https://support.hashicorp.com/)
- **HCP Platform**: Contact [HCP Support](https://support.hashicorp.com/)
- **Vault functionality**: See [Vault Documentation](https://developer.hashicorp.com/vault)

## License

This configuration is provided as-is for use with HashiCorp Cloud Platform.