@description('Storage account name')
param storage_account_name string

@description('Storage account location')
param location string 

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storage_account_name
  location: location
  kind: 'StorageV2'
  properties:{
    minimumTlsVersion: 'TLS1_2'
    supportsHttpsTrafficOnly: true 
    networkAcls: {
      defaultAction: 'Deny' 
    }
  }
  sku: {
    name: 'Premium_LRS'
  }
}

output storageAccountName string = storageaccount.name
