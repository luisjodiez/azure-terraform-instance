# azure-terraform-instance

## Initial setup

Intended use with a couple workspaces "eu" and "us" to mimic multi-region deployments.

May as well use them for "pre" and "pro" environments. Simplified that to make no use of workspaces.

Working on the integration with Azure for the github actions.

https://learn.microsoft.com/en-us/azure/app-service/deploy-github-actions?tabs=openid

## Troubleshooting

Azure errors: https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/common-deployment-errors
- Manual fix on registrations for namespaces Microsoft.Network & Microsoft.Compute

### Registrations setup

Azure-cli: https://learn.microsoft.com/en-us/azure/azure-resource-manager/troubleshooting/error-register-resource-provider?tabs=azure-cli
