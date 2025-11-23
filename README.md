# Terraform Azure Construct

Terraform Deployment modules that deploy resources on Azure cloud.
These modules deploy bunch of resources with all required configurations considering monitoring, availability and reliability.    

- **Terraform version** >= `0.15.0`

## Modules

- [terraform-azure-core-modules](https://github.com/cloudops92/terraform-azure-core-modules)
  
## Modules

- [aad-service-principal](terraform/aad-service-principal)
- [acmebot](terraform/acmebot)
- [aks](terraform/aks)
- [aks-authorization](terraform/aks-authorization)
- [aks-node-pool](terraform/aks-node-pool)
- [aks-private-dns-zone](terraform/aks-private-dns-zone)
- [aks-rancher-import](terraform/aks-rancher-import)
- [alert-action-group](terraform/alert-action-group)
- [app-gateway](terraform/app-gateway)
- [cache-redis](terraform/cache-redis)
- [chartmuseum](terraform/chartmuseum)
- [container-registry](terraform/container-registry)
- [cosmosdb-mongodb](terraform/cosmosdb-mongodb)
- [database-server-mysql](terraform/database-server-mysql)
- [database-server-postgresql](terraform/database-server-postgresql)
- [database-server-postgresql-replica](terraform/database-server-postgresql-replica)
- [dns-zone-private](terraform/dns-zone-private)
- [dns-zone-public](terraform/dns-zone-public)
- [elk](terraform/elk)
- [grafana](terraform/grafana)
- [influxdb](terraform/influxdb)
- [jenkins](terraform/jenkins)
- [keyvault](terraform/keyvault)
- [logic-app-integration-account](terraform/logic-app-integration-account)
- [managed-identity](terraform/managed-identity)
- [matomo](terraform/matomo)
- [metabase](terraform/metabase)
- [nexus](terraform/nexus)
- [rancher](terraform/rancher)
- [resource-group](terraform/resource-group)
- [slack-notifier](terraform/slack-notifier)
- [sonarqube](terraform/sonarqube)
- [storage-account](terraform/storage-account)
- [virtual-machine-linux](terraform/virtual-machine-linux)
- [virtual-machine-placement-group](terraform/virtual-machine-placement-group)
- [virtual-network](terraform/virtual-network)
- [virtual-network-gateway](terraform/virtual-network-gateway)
- [virtual-network-old](terraform/virtual-network-old)
- [virtual-network-peering](terraform/virtual-network-peering)
   

## Development

### Directory structure

Terraform directory hold the various modules code.

```
|-- resource-group
|   |-- main.tf
|   |-- resource_group.tf
|   `-- variables.tf
`-- virtual-network
    |-- main.tf
    |-- variables.tf
    `-- virtual_network.tf
```


## Overview

- **Maintainer**: mishalshah92@gmail.com


## Releases

Click [here](RELEASES.md) to view Releases!!!