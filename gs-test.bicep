resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'gueray1975' //must be globally unique
  location: 'northeurope'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    supportsHttpsTrafficOnly: true
  }
}
