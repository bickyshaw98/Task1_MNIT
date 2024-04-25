@minLength(3)
@maxLength(3)
param agencyCode string

@allowed([
  'p'
  't'
  'd'
])
param envCode string
param name string
param numberCode string = '001'
param tags object
param location string

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: '${agencyCode}${envCode}-${name}-rg-${numberCode}'
  location: location
  tags: tags
}
