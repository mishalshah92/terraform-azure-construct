# Terraform Azure Deployments

Terraform Deployment modules that deploy resources on Azure cloud.
These modules deploy bunch of resources with all required configurations considering monitoring, availability and reliability.    

- **Terraform version** >= `0.15.0`

## Modules

- [terraform-azure-modules](https://github.com/cloudops92/terraform-azure-modules)
  
## Modules

- [acmebot](src/acmebot)
- [aks](src/aks)  
- [aks-nodepool](src/aks-nodepool)
- [alert-action-group](src/alert-action-group)  
- [cache-redis](src/cache-redis)
- [container-registry](src/container-registry)
- [cosmosdb-mongodb](src/cosmosdb-mongodb)  
- [database-server-postgresql](src/database-server-postgresql)
- [database-server-postgresql-replica](src/database-server-postgresql-replica)
- [dns-zone-private](src/dns-zone-private)
- [dns-zone-public](src/dns-zone-public)
- [keyvault](src/keyvault) 
- [resource-group](src/resource-group)   
- [slack-notifier](src/slack-notifier)
- [storage-account](src/storage-account)
- [virtual-machine-linux](src/virtual-machine-linux)
- [virtual-machine-placement-group](src/virtual-machine-placement-group)
- [virtual-network](src/virtual-network)
- [virtual-network-gateway](src/virtual-network-gateway)
- [virtual-network-old](src/virtual-network-old)  
- [virtual-network-peering](src/virtual-network-peering)    

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

- **Maintainer**: mishalshah1992@gmail.com


## Releases

Click [here](RELEASES.md) to view Releases!!!