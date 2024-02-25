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

// Intentionally fail the deployment in a custom script
resource deploymentScript 'Microsoft.Resources/deploymentScripts@2022-05-01' = {
  name: 'failDeploymentScript'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: '''
      Write-Host "Intentionally failing the deployment"
      exit 1
    '''
    arguments: '-storageAccountName', storageAccount.name
  }
}

output deploymentScriptOutput string = deploymentScript.properties.outputs['outputVariableName']
