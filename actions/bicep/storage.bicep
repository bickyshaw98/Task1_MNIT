param appName string
param location string
param skuName string = 'F1'
param skuCapacity int = 1

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: '${appName}-asp'
  location: location
  sku: {
    name: skuName
    capacity: skuCapacity
  }
}

resource webApp 'Microsoft.Web/sites@2020-12-01' = {
  name: appName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    clientCertEnabled: true
    azureADAuthEnabled: true
    siteConfig: {
      minTlsVersion: '1.2'
      http20Enabled: true
    }
  }
}

output webAppUrl string = webApp.properties.defaultHostName
