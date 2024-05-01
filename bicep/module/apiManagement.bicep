@description('Optional. Location for all resources.')
param location string = resourceGroup().location

@description('The name of the API Management service instance')
param apiManagementServiceName string


@description('The email address of the owner of the service')
@minLength(1)
param publisherEmail string

@description('The name of the owner of the service')
@minLength(1)
param publisherName string

@description('The pricing tier of this API Management service')
@allowed([
  'Consumption'
  'Developer'
  'Basic'
  'Basicv2'
  'Standard'
  'Standardv2'
  'Premium'
])
param sku string = 'Developer'

@description('The instance size of this API Management service.')
@allowed([
  0
  1
  2
])
param skuCount int = 1

param logAnalyticsWorkspaceId string
param diagnosticSettingName string
param diagnosticLogsRetentionInDays int
param lockName string



param tags object

//API Mangement
resource apiManagementService 'Microsoft.ApiManagement/service@2023-05-01-preview' = {
  name: apiManagementServiceName
  location: location
  sku: {
    name: sku
    capacity: skuCount
  }
  properties: {
    publisherEmail: publisherEmail
    publisherName: publisherName
  }
  tags: tags
}

output apiManagementResourceId string = apiManagementService.id

resource resourceLock 'Microsoft.Authorization/locks@2016-09-01' = {
  name: lockName
  properties: {
    level: 'CanNotDelete'
  }
  scope: apiManagementService
}

resource apimDiagnosticSetting 'Microsoft.ApiManagement/service/diagnosticSettings@2020-06-01-preview' = {
  name: '${apiManagementServiceName}-${diagnosticSettingName}'
  properties: {
    logs: [
      {
        category: 'AllMetrics'
        enabled: true
      }
      {
        category: 'GatewayLogs'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
    storageAccountId: logAnalyticsWorkspaceId
    retentionPolicy: {
      days: diagnosticLogsRetentionInDays
      enabled: true
    }
  }
  scope: apiManagementService
}
