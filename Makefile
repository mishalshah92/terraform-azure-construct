REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
COMMIT:=$(MODULE)_$(DEPLOYMENT)_$(DATE)_$(REV)
REPO_PATH:=$(PWD)

# Defaults
SUBSCRIPTION:=NO_SUBSCRIPTION
RG:=$(RG)
MODULE:=NO_MODULE
LOCATION:=NO_REGION
DEPLOYMENT:=NO_DEPLOYMENT

REPO:=https://github.com/cloudops92/terraform-azure-deployment-values

# Terraform Var files
MODULE_PATH:=src/$(MODULE)
MODULE_VAR_FILE:=$(REPO_PATH)/values/$(SUBSCRIPTION)/$(RG)/$(MODULE)/$(LOCATION)/$(DEPLOYMENT).tfvars

# Terraform backend configs
TF_BACKEND_RESOURCE_GROUP_NAME=hub
TF_BACKEND_RESOURCE_GROUP_LOCATION=centralindia
TF_BACKEND_STORAGE_SUBSCRIPTION_NAME=trraformstate
TF_BACKEND_ENVIRONMENT=public
TF_BACKEND_CONTAINER_NAME=terraform-azure-deployment-values
TF_BACKEND_KEY:=$(SUBSCRIPTION)/$(RG)/$(MODULE)/$(LOCATION)/$(DEPLOYMENT)/terraform.tfstate

TF_PLAN_FILE:=$(SUBSCRIPTION)_$(RG)_$(MODULE)_$(LOCATION)_$(DEPLOYMENT)_$(REV)

install:
	tfenv install

azure-init:
	az group create --name $(TF_BACKEND_RESOURCE_GROUP_NAME) --location $(TF_BACKEND_RESOURCE_GROUP_LOCATION)
	az storage account create --resource-group $(TF_BACKEND_RESOURCE_GROUP_NAME) --name $(TF_BACKEND_STORAGE_SUBSCRIPTION_NAME) --sku Standard_LRS --encryption-services blob
	az storage container create --name $(TF_BACKEND_CONTAINER_NAME) --account-name $(TF_BACKEND_STORAGE_SUBSCRIPTION_NAME) --auth-mode login

get: clean
	terraform -chdir=$(MODULE_PATH) get -update

init: clean
	terraform -chdir=$(MODULE_PATH) init \
		-backend-config='resource_group_name=$(TF_BACKEND_RESOURCE_GROUP_NAME)' \
		-backend-config='storage_account_name=$(TF_BACKEND_STORAGE_SUBSCRIPTION_NAME)' \
		-backend-config='container_name=$(TF_BACKEND_CONTAINER_NAME)' \
		-backend-config='environment=$(TF_BACKEND_ENVIRONMENT)' \
		-backend-config='key=$(TF_BACKEND_KEY)' -upgrade

validate:
	terraform -chdir=$(MODULE_PATH) validate

refresh:
	terraform -chdir=$(MODULE_PATH) refresh -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RG)' \
        -var 'location=$(LOCATION)' \
        -var 'repo=$(REPO)' \
        -var 'module=$(MODULE)' \
        -var 'deployment=$(DEPLOYMENT)' \
        -var-file=$(MODULE_VAR_FILE)


plan: validate
	terraform -chdir=$(MODULE_PATH) plan \
		-var 'resource_group=$(RG)' \
		-var 'location=$(LOCATION)' \
		-var 'repo=$(REPO)' \
		-var 'module=$(MODULE)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var-file=$(MODULE_VAR_FILE) \
		-out=$(TF_PLAN_FILE).tfplan

plan-destroy: validate
	terraform -chdir=$(MODULE_PATH) plan -destroy -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RG)' \
		-var 'location=$(LOCATION)' \
		-var 'repo=$(REPO)' \
		-var 'module=$(MODULE)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var-file=$(MODULE_VAR_FILE) \
		-out=$(TF_PLAN_FILE).tfplan

apply: validate
	terraform -chdir=$(MODULE_PATH) apply -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RG)' \
		-var 'location=$(LOCATION)' \
		-var 'repo=$(REPO)' \
		-var 'module=$(MODULE)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var-file=$(MODULE_VAR_FILE)

apply-plan:
	terraform apply -state=$(TF_BACKEND_KEY) $(TF_PLAN_FILE).tfplan

destroy: validate
	terraform -chdir=$(MODULE_PATH) destroy -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RG)' \
		-var 'location=$(LOCATION)' \
		-var 'repo=$(REPO)' \
        -var 'module=$(MODULE)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var-file=$(MODULE_VAR_FILE)

clean:
	rm -rf .terraform/ || true
	rm *.tfplan  || true
	find . -type d -name ".terraform" -exec rm -rf "{}" \;
	find . -name "*.tfplan" -exec rm -f "{}" \;