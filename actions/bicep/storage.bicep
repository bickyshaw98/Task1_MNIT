
param rgName string
param location string = 'East US'

resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'mystorageaccount15041995'
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}

resource appService 'Microsoft.Web/sites@2021-02-01' = {
  name: 'myappservice15041995'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'myserviceplan'
  location: location
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
  }
}

resource vm 'Microsoft.Compute/virtualMachines@2021-07-01' = {
  name: 'myvirtualmachine'
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_DS1_v2'
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-Datacenter'
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerName: 'myvm'
      adminUsername: 'BickyShaw'
      adminPassword: 'your-password'
    }
  }
}

output rgName string = rgName
