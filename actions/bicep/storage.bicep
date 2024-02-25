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

output storageAccountProvisioningState string = storageAccount.properties.provisioningState

resource failDeployment 'Microsoft.Resources/deployments@2019-10-01' = {
  name: 'failDeployment'
  resourceGroup: 'demo-rg'
  properties: {
    mode: 'Incremental'
    template: {
      contentVersion: '1.0.0.0'
      resources: [
        {
          type: 'Microsoft.Storage/storageAccounts/providers/readWriteValues'
          apiVersion: '2019-08-01'
          name: storageAccountName
          properties: {
            readWriteProperty: 'FailDeployment'
          }
        }
      ]
    }
  }
}
