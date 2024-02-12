param storageAccounts array

// Iterate over storage accounts
for storageAccount in storageAccounts {
  resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
    name: storageAccount.name
    location: storageAccount.location
    kind: 'StorageV2'
    sku: {
      name: 'Standard_LRS'
    }
  }
}
