# validate.ps1
# Get current App Service configuration
$currentConfig = Get-AzWebApp -ResourceGroupName demo-rg -Name webAppMNIT2-POC | ConvertTo-Json

# Compare with expected configuration
$expectedConfig = Get-Content -Path webapp.bicep | ConvertFrom-Json

if ($currentConfig -ne $expectedConfig) {
    Write-Output "Manual changes detected in App Service configuration. Aborting deployment."
    exit 1
} else {
    Write-Output "No manual changes detected. Proceeding with deployment."
}
