param storageAccountName string
param location string = 'East US'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'InvalidSkuName' // Intentional error
  }
  kind: 'StorageV2'
}
