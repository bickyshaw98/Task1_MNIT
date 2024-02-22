param storageAccountName string
param location string = resourceGroup().location
param sku string = 'Invalid_Sku_Value'

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: sku
  }
  kind: 'Invalid_Kind_Value'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
