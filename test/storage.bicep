param storageAccountName string
@description('The name of the storage account.')
param location string = resourceGroup().location 
@description('The region in which to deploy the resources.')

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}
