Write-Output "App Services and their connected GitHub repositories:"
$apps = az webapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o json | ConvertFrom-Json
foreach ($app in $apps) {
    $repo = az webapp deployment source show -g $app.resourceGroup -n $app.name --query "repoUrl" -o tsv
    if (![string]::IsNullOrWhiteSpace($repo)) {
        Write-Output "App Service: $($app.name), Resource Group: $($app.resourceGroup), GitHub Repo: $repo"
    }
}

Write-Output "`nStatic Web Apps and their connected GitHub repositories:"
$staticApps = az staticwebapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o json | ConvertFrom-Json
foreach ($staticApp in $staticApps) {
    $repo = az staticwebapp show -n $staticApp.name -g $staticApp.resourceGroup --query "repositoryUrl" -o tsv
    if (![string]::IsNullOrWhiteSpace($repo)) {
        Write-Output "Static Web App: $($staticApp.name), Resource Group: $($staticApp.resourceGroup), GitHub Repo: $repo"
    }
}
