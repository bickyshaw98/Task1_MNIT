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

param appSettingsObj object = {
  Setting1: 'Value1'
  Setting2: 'Value2'
}



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
    siteConfig: {
      appSettings: [
        {
          name: 'Setting1'
          value: 'Value1'
        }
        {
          name: 'Setting2'
          value: 'Value2'
        }
      ]
    }
  }
}

output webAppUrl string = webApp.properties.defaultHostName

