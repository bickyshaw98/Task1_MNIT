param rgName string
param location string
param storageAccountName string
param appServiceName string
param vnetName string
param subnetName string

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: '${appServiceName}-plan'
  location: location
  sku: {
    name: 'P1v2'
    tier: 'Premium'
  }
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: appServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
  }
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2021-05-01' = {
  name: subnetName
  parent: virtualNetwork
  properties: {
    addressPrefix: '10.0.0.0/24'
  }
}

// Intentionally fail the deployment in a custom script
resource deploymentScript 'Microsoft.Resources/deploymentScripts@2020-10-01' = {
  name: 'failDeploymentScript'
  location: location
  kind: 'AzurePowerShell'
  identity: {
    type: 'UserAssigned'
  }
  properties: {
    azPowerShellVersion: '3.0'
    scriptContent: '''
      Write-Host "Failed"
      exit 1
    '''
  }
}

output rgName string = rgName
