param location string = resourceGroup().location

//Frontend blob storage module
module staticSiteBlob 'modules/staticsiteblob.bicep' = {
  name: 'staticSiteBlob'
  params: {
    location: location
  }
}

//Cosmos DB NoSQL module
module cosmosDbNoSql 'modules/cosmosdbnosql.bicep' = {
  name: 'cosmosDbNoSql'
  params: {
    location: location
  }
}

//Front Door module
module frontdoor 'modules/frontdoor.bicep' = {
  name: 'frontdoor'
}

//Function App module
module functionApp 'modules/functionapp.bicep' = {
  name: 'functionApp'
  params: {
    location: location
  }
}

output storageAccountId string = staticSiteBlob.outputs.storageAccountId
output cosmosDbNoSqlAccountId string = cosmosDbNoSql.outputs.cosmosDbNoSqlAccountId
output frontdoor_name_id string = frontdoor.outputs.frontdoor_name_id
output frontdoor_name_endpoint_id string = frontdoor.outputs.frontdoor_name_endpoint_id
output functionAppId string = functionApp.outputs.functionAppId
output functionAppName string = functionApp.outputs.functionAppName
