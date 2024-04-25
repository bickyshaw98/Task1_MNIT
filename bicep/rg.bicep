param location string
param rgName string
param tags object
param agencyCode string
//
targetScope = 'subscription'
var resource_group_name = '${agencyCode}-${rgName}'
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resource_group_name
  location: location
  tags: tags
}
 