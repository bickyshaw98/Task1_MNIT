targetScope = 'resourceGroup'

@description('The location into which the Azure resources should be deployed.')
param location string = resourceGroup().location

@description('Required. The State of Minnesota Agency code (3-characters).')
@minLength(3)
@maxLength(3)
param agencyCode string

@description('Required. The 1-character code representing the environment (Production, Development, Test, Staging, Reference).')
@allowed([
  'p'
  'd'
  't'
  's'
  'r'
])
param envCode string

param numberCode string = '001'
param applicationName string

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

@description('Optional. The name of the Diagnostic setting.')
param diagnosticSettingName string = 'service'

@description('Optional. Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely.')
@minValue(0)
@maxValue(365)
param diagnosticLogsRetentionInDays int
param lockName string

param tags object


var logAnalyticsName = '${agencyCode}${envCode}-log-${numberCode}'

// Create Log Analytics Workspace
module logAnalytics 'br:g46piacregistrycr01.azurecr.io/bicep/modules/rg/loganalytics:2024-04-05' = {
  name: 'logAnalytics'
  params: {
    logAnalyticsWorkspaceName: logAnalyticsName
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
    dailyQuotaGb: 1
    gallerySolutions: [
      'AzureAutomation'
    ]
    useResourcePermissions: true
    tags: tags
  }
}



// Enable Application Insights
module appinsights 'br:g46piacregistrycr01.azurecr.io/bicep/modules/rg/appinsights:2024-04-05' = {
  name: 'appInsightDeploy'
  params: {
    agencyCode: agencyCode
    appName: applicationName
    envCode: envCode
    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsResourceId
    tags: tags
  }
}


// Lock the resource
//resource resourceLock 'Microsoft.Authorization/locks@2016-09-01' = {
//  name: lockName
//  properties: {
//    level: 'CanNotDelete'
//  }
//  scope: apiManagementServiceName
//}

// Calling APIM module
module apiManagement './module/apiManagement.bicep' = {
  name: 'Deploying-API-Management-In-Shared-Service'
  params: {
    location: location
    apiManagementServiceName: apiManagementServiceName
    lockName: lockName
    diagnosticLogsRetentionInDays: diagnosticLogsRetentionInDays
    diagnosticSettingName: diagnosticSettingName
    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsResourceId
    sku: sku
    skuCount: skuCount
    publisherEmail: publisherEmail
    publisherName: publisherName
    tags: tags
  }
}

// Calling Diagonostic Setting Module
//module apimDiagnosticSettings './module/diagnosticSettings.bicep' = {
//  name: 'Deploying-API-Management-Diagnostic-Settings'
//  params: {
//    apiManagementServiceName: apiManagementServiceName
//    logAnalyticsWorkspaceId: logAnalytics.outputs.logAnalyticsResourceId
//    diagnosticSettingName: diagnosticSettingName
//    diagnosticLogsRetentionInDays: diagnosticLogsRetentionInDays
//  }
//}
