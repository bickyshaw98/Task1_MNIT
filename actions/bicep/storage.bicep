@description('Storage account name')
param storage_account_name string

@description('Storage account location')
param location string 

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true // Enable 'Trusted Microsoft Services'
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices' // Allow trusted Microsoft services
    }
  }
  sku: {
    name: 'Premium_LRS'
  }
}

output storageAccountName string = storageaccount.name
