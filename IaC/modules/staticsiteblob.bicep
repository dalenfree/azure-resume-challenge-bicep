param location string = resourceGroup().location

var frontend_storageAccount string = 'fblob${uniqueString(resourceGroup().id)}'

resource frontend_storageAccount_resource 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: frontend_storageAccount
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    largeFileSharesState: 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource frontend_storageAccount_default 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  parent: frontend_storageAccount_resource
  name: 'default'
  properties: {
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_frontend_storageAccount_default 'Microsoft.Storage/storageAccounts/fileServices@2025-01-01' = {
  parent: frontend_storageAccount_resource
  name: 'default'
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_frontend_storageAccount_default 'Microsoft.Storage/storageAccounts/queueServices@2025-01-01' = {
  parent: frontend_storageAccount_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_frontend_storageAccount_default 'Microsoft.Storage/storageAccounts/tableServices@2025-01-01' = {
  parent: frontend_storageAccount_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource frontend_storageAccount_default_web 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: frontend_storageAccount_default
  name: '$web'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
}
output storageAccountId string = frontend_storageAccount_resource.id
