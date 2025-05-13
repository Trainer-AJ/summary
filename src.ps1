# GitHub Token and Headers
$githubToken = "github_pat_xxxxxxxxxxxxlY"
$headers = @{
    "Accept" = "application/vnd.github+json"
    "Authorization" = "Bearer $githubToken"
    "X-GitHub-Api-Version" = "2022-11-28"
}

$output = @()

Write-Output "App Services and their connected GitHub repositories:"
$apps = az webapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o json | ConvertFrom-Json
foreach ($app in $apps) {
    $repoUrl = az webapp deployment source show -g $app.resourceGroup -n $app.name --query "repoUrl" -o tsv
    if (![string]::IsNullOrWhiteSpace($repoUrl)) {
        Write-Output "App Service: $($app.name), Resource Group: $($app.resourceGroup), GitHub Repo: $repoUrl"
        if ($repoUrl -match "github.com[:/](.+)/(.+?)(\.git)?$") {
            $owner = $matches[1]
            $repo = $matches[2]
            $apiUrl = "https://api.github.com/repos/$owner/$repo/collaborators"
            try {
                $collaborators = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get
                foreach ($collab in $collaborators) {
                    $output += "App Service: $($app.name), Repo: $owner/$repo, Collaborator: $($collab.login)"
                }
            } catch {
                $output += "Failed to fetch collaborators for $owner/$repo: $($_.Exception.Message)"
            }
        }
    }
}

Write-Output "`nStatic Web Apps and their connected GitHub repositories:"
$staticApps = az staticwebapp list --query "[].{name:name, resourceGroup:resourceGroup}" -o json | ConvertFrom-Json
foreach ($staticApp in $staticApps) {
    $repoUrl = az staticwebapp show -n $staticApp.name -g $staticApp.resourceGroup --query "repositoryUrl" -o tsv
    if (![string]::IsNullOrWhiteSpace($repoUrl)) {
        Write-Output "Static Web App: $($staticApp.name), Resource Group: $($staticApp.resourceGroup), GitHub Repo: $repoUrl"
        if ($repoUrl -match "github.com[:/](.+)/(.+?)(\.git)?$") {
            $owner = $matches[1]
            $repo = $matches[2]
            $apiUrl = "https://api.github.com/repos/$owner/$repo/collaborators"
            try {
                $collaborators = Invoke-RestMethod -Uri $apiUrl -Headers $headers -Method Get
                foreach ($collab in $collaborators) {
                    $output += "Static Web App: $($staticApp.name), Repo: $owner/$repo, Collaborator: $($collab.login)"
                }
            } catch {
                $output += "Failed to fetch collaborators for $owner/$repo: $($_.Exception.Message)"
            }
        }
    }
}

# Save to file
$output | Out-File -FilePath "GitHubRepoCollaborators.txt" -Encoding UTF8
Write-Output "Results saved to GitHubRepoCollaborators.txt"
