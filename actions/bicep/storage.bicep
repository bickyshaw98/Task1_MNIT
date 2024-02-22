resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'storageaccount15041995'
  location: 'East US'
  sku: {
    name: 'InvalidSkuName' // Intentional error
  }
  kind: 'StorageV2'
}
