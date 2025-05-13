# Log in to Azure
az login

# Set your subscription ID
subscriptionId="your_subscription_id"
az account set --subscription $subscriptionId

# List all App Services and their connected GitHub repositories
echo "App Services and their connected GitHub repositories:"
az webapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o tsv | while read -r name resourceGroup; do
    repo=$(az webapp deployment source show -g $resourceGroup -n $name --query "repoUrl" -o tsv)
    if [ -n "$repo" ]; then
        echo "App Service: $name, Resource Group: $resourceGroup, GitHub Repo: $repo"
    fi
done

# List all Static Web Apps and their connected GitHub repositories
echo "Static Web Apps and their connected GitHub repositories:"
az staticwebapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o tsv | while read -r name resourceGroup; do
    repo=$(az staticwebapp show -n $name -g $resourceGroup --query "repositoryUrl" -o tsv)
    if [ -n "$repo" ]; then
        echo "Static Web App: $name, Resource Group: $resourceGroup, GitHub Repo: $repo"
    fi
done
