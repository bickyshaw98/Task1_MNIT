param storageAccounts array

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' = {
  name: subnetName
  parent: vnet
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

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
