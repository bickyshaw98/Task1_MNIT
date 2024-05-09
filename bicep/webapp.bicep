//// storage.bicep
////deploying storage account and app service
//
//param storageAccountName string
////param appServicePlanName string
////param webAppName string
//param location string
//
//resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
//  name: storageAccountName
//  location: location
//  kind: 'StorageV2'
//  sku: {
//    name: 'Standard_LRS'
//  }
//}

param appServicePlanName string
param location string
param webAppName string


resource appServicePlan 'Microsoft.Web/serverfarms@2019-08-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: 'F1'
    tier: 'Free'
    size: 'F1'
  }
  properties: {
    reserved: true
  }
}

resource webApp 'Microsoft.Web/sites@2019-08-01' = {
  name: webAppName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
  }
}

output webAppUrl string = webApp.properties.defaultHostName

