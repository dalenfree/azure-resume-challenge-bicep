
var frontdoor_name string = 'fd${uniqueString(resourceGroup().id)}'

resource frontdoor_name_resource 'Microsoft.Cdn/profiles@2025-04-15' = {
  name: frontdoor_name
  location: 'Global'
  sku: {
    name: 'Standard_AzureFrontDoor'
  }
}

resource frontdoor_name_frontdoor_name_endpoint 'Microsoft.Cdn/profiles/afdendpoints@2025-04-15' = {
  parent: frontdoor_name_resource
  name: '${frontdoor_name}endpoint'
  location: 'Global'
  properties: {
    enabledState: 'Enabled'
  }
}

resource frontdoor_name_default_origin_group_bf2e5ecd 'Microsoft.Cdn/profiles/origingroups@2025-04-15' = {
  parent: frontdoor_name_resource
  name: 'default-origin-group-bf2e5ecd'
  properties: {
    loadBalancingSettings: {
      sampleSize: 4
      successfulSamplesRequired: 3
      additionalLatencyInMilliseconds: 50
    }
    healthProbeSettings: {
      probePath: '/'
      probeRequestType: 'HEAD'
      probeProtocol: 'Http'
      probeIntervalInSeconds: 100
    }
    sessionAffinityState: 'Disabled'
  }
}

output frontdoor_name_id string = frontdoor_name_resource.id
output frontdoor_name_endpoint_id string = frontdoor_name_frontdoor_name_endpoint.id
