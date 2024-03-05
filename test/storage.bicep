@description('The name of the storage account.')
param storageAccountName string 
@description('The location where the resources will be deployed.')
param location string = resourceGroup().location 

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
