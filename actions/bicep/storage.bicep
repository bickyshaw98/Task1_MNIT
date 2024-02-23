param storageAccountName string
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}


resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'scriptDeployment'
  location: 'East US'
  kind: 'AzurePowerShell'
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: 'Write-Error "Intentional error during deployment"; exit 1'
    timeout: 'PT10M'
    retentionInterval: 'P1D'
  }
}
