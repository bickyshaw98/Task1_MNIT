@description('storage account name')
param storage_account_name string

@description('storage account location')
param location string

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Deny'
    }
  }
  sku: {
    name: 'Premium_LRS'
  }
}



