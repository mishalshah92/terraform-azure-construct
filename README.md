# Terraform Azure Modules

Terraform modules to deploy resources on deploy on Azure cloud with its possible configurations.
These modules deploy bunch of resources with all required configurations considering monitoring, availability and reliability.    

## Base Modules

- [terraform-azure-base-modules](https://github.com/cloudops92/terraform-azure-base-modules)
  
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

Values directory store the terraform values in path `subscriptions -> resource-group -> region -> module -> {profile}.tfvars`

```
values/
`-- ms-azure-sponsorship
    `-- dev
        `-- eastus
            |-- resource-group
            |   `-- my-dev-rg.tfvars

```

### Terraform state info

- ResourceGroupName: `terraform-rg`
- StorageAccountName: `tfstate`
- Environment: `public`
- ContainerName: `terraform-azure-deploy`
- STATE_PATH: `$(ACCOUNT)/$(RESOURCE_GROUP)/$(LOCATION)/$(MODULE)/$(DEPLOYMENT)/terraform.tfstate`


### Make Targets

With each `make` target below input is mandatory.

- `ACCOUNT`: Name of the aws account.
- `CUSTOMER`: Name of the customer.
- `ENV`: Environment to deploy.
- `Location`: Azure region/location.
- `MODULE`: Name of the module to deploy.
- `DEPLOYMENT`: Name of the deployment to deploy.

Make sure you have that environment following directory structure.

#### Targets

- `$ make init`  

    Running `terraform init...` to initialize terraform. 
    
- `$ make validate`  

    Running `terraform validate...` to validate the Terraform syntax.

- `$ make plan`  

    Running `terraform plan...` to print the plan. 

- `$ make plan-destroy`

  Running `terraform plan -destroy...` to print the plan for removing resources.

- `$ make apply`  

    Running `terraform apply...` to execute deployment. 

- `$ make apply-plan`

  Running `terraform apply...` with plan.

- `$ make destroy`  

    Running `terraform destroy` to destroy the deployment. 

#### Examples

```
$ make init ACCOUNT=ms-azure-sponsorship CUSTOMER=customer ENV=dev LOCATION=eastus MODULE=resource-group DEPLOYMENT=dev
$ make validate ACCOUNT=ms-azure-sponsorship CUSTOMER=customer ENV=dev LOCATION=eastus MODULE=resource-group DEPLOYMENT=dev
$ make plan ACCOUNT=ms-azure-sponsorship CUSTOMER=customer ENV=dev LOCATION=eastus MODULE=resource-group DEPLOYMENT=dev
$ make apply ACCOUNT=ms-azure-sponsorship CUSTOMER=customer ENV=dev LOCATION=eastus MODULE=resource-group DEPLOYMENT=dev
$ make destroy ACCOUNT=ms-azure-sponsorship CUSTOMER=customer ENV=dev LOCATION=eastus MODULE=resource-group DEPLOYMENT=dev
```

### How to init git-crypt?

1. Execute `$ git-crypt init`.
2. Add the `.gitattributes` file. Rule will work for child files and folders.
3. Define the file-type to encrypt.
    ```
    *.crt filter=git-crypt diff=git-crypt
    *.key filter=git-crypt diff=git-crypt
    ```

### How to add GPG user into git-crypt?

1. Get the key `$ gpg --list-keys`

```
/Users/someuser/.gnupg/pubring.kbx
----------------------------------
pub rsa2048 2019-01-07 [SC] [expires: 2021-01-06]
    D2B3EAAF9A8D5DB93CC30B26CCA243599CC80727B
uid           [ultimate] Your Name <your@email.com>
sub   rsa2048 2019-01-07 [E] [expires: 2021-01-06]
```

2. Add user `$ git-crypt add-gpg-user D2B3EAAF9A8D5DB93CC30B26CCA243599CC80727B`.

3. To unlock, execute `$ git-crypt unlock`

4. To lock, execute `$ git-crypt lock`


## Overview

- **Maintainer**: mishalshah1992@gmail.com


## Releases

Click [here](RELEASES.md) to view Releases!!!