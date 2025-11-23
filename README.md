# Terraform Azure Construct

`terraform-azure-construct` provides high-level, reusable Terraform “constructs” for Azure infrastructure.
Built on top of foundational modules (e.g., those in terraform-azure-core-modules), this repo focuses on composing 
common infrastructure patterns—such as a full landing-zone, network/security baseline, or application stack—into 
easy-to-consume solution pack-ages.

These constructs are opinionated yet configurable, enabling teams to deploy robust, consistent Azure architectures with 
minimal duplicate effort.

## Key Features
- Pre-composed architecture patterns (virtual network + subnets + NSGs, landing zone, platform services, etc.)
- Built using Terraform modules, assembled for production readiness
- Configurable inputs and overrides for flexibility across environments
- Enforces consistency in naming, tagging, and resource structure
- Designed for speed of deployment while maintaining best-practice foundations

## Why Use It?
If your team uses Azure and Terraform, this repo helps you:
- Deploy full infrastructure “stacks” rather than building every component from scratch
- Leverage the module library (terraform-azure-core-modules) but stop reinventing composition logic
- Achieve standardization across dev/test/prod environments
- Enable rapid time-to-value while retaining extensibility

**Terraform version** >= `0.15.0`

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

Values directory store the terraform values in path `account -> resource-group -> module -> location -> {deployment}.tfvars`

```
values
`-- ms-azure-account
    `-- resource-group
        `-- chartmuseum
            |-- centralindia
                `-- example.tfvars
```

## Terraform state info

- ResourceGroupName: `myhub-rg`
- StorageAccountName: `tfstate`
- Environment: `public`
- ContainerName: `terraform-azure-deployments`
- STATE_PATH: `$(ACCOUNT)/$(RESOURCE_GROUP)/$(MODULE)/$(LOCATION)/$(DEPLOYMENT)/terraform.tfstate`

## Make Targets

With each `make` target below input is mandatory.

- `ACCOUNT`: Name of the aws account.
- `CUSTOMER`: Name of the customer.
- `ENV`: Environment to deploy.
- `Location`: Azure region/location.
- `MODULE`: Name of the module to deploy.
- `DEPLOYMENT`: Name of the deployment to deploy.
- `RESOURCE_GROUP`: Name of the resource group.

Make sure you have that environment following directory structure.

### Targets

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

### Examples

```
$ make init RG=myrg ACCOUNT=ms-azure CUSTOMER=customer ENV=example LOCATION=centralindia MODULE=chartmuseum DEPLOYMENT=example
$ make validate RG=myrg ACCOUNT=ms-azure CUSTOMER=customer ENV=example LOCATION=centralindia MODULE=chartmuseum DEPLOYMENT=example
$ make plan RG=myrg ACCOUNT=ms-azure CUSTOMER=customer ENV=example LOCATION=centralindia MODULE=chartmuseum DEPLOYMENT=example
$ make apply RG=myrg ACCOUNT=ms-azure CUSTOMER=customer ENV=example LOCATION=centralindia MODULE=chartmuseum DEPLOYMENT=example
$ make destroy RG=myrg ACCOUNT=ms-azure CUSTOMER=customer ENV=example LOCATION=centralindia MODULE=chartmuseum DEPLOYMENT=example
```

## How to init git-crypt?

1. Execute `$ git-crypt init`.
2. Add the `.gitattributes` file. Rule will work for child files and folders.
3. Define the file-type to encrypt.
    ```
    *.crt filter=git-crypt diff=git-crypt
    *.key filter=git-crypt diff=git-crypt
    ```

## How to add GPG user into git-crypt?

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

## Maintainer

Mishal Shah -- _mishalshah92@gmail.com_


## Contribution
Contributions are welcome! Whether it's adding new constructs, improving existing ones, or enhancing 
documentation — please fork the repo, submit a pull request, and adhere to the existing structure and style.

## Releases

Click [here](RELEASES.md) to view Releases!!!