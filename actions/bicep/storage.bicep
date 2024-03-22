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
    siteConfig: {
      httpsOnly: true // Ensure HTTPS-only traffic
      minTlsVersion: '1.2' // Ensure TLS 1.2 or higher
      clientCertEnabled: true // Enable client certificates
      azureADAuthEnabled: true // Enable Azure AD authentication
      http20Enabled: true // Enable HTTP/2
    }
  }
}

output webAppUrl string = webApp.properties.defaultHostName
