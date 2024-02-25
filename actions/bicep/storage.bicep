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

resource deployment 'Microsoft.Resources/deployments@2019-10-01' = {
  name: 'failDeployment'
  location: location
  properties: {
    mode: 'Incremental'
    template: {
      $schema: 'https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#',
      contentVersion: '1.0.0.0',
      resources: []
    }
    parameters: {
      shouldFail: {
        value: true
      }
    }
  }
}
