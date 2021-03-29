REV:=$(shell git rev-parse --short HEAD)
DATE:=$(shell date +%Y.%m.%d-%H.%M.%S)
COMMIT:=$(MODULE)_$(DEPLOYMENT)_$(DATE)_$(REV)

# Defaults
ACCOUNT:=NO_ACCOUNT
CUSTOMER:=customer
ENV:=NO_ENV
LOCATION:=NO_REGION
MODULE:=NO_MODULE
DEPLOYMENT:=default
OUTPUT:=id

RESOURCE_GROUP:=$(CUSTOMER)-$(ENV)
REPO:=https://github.com/mishah92/terraform-azure-deployments

# Terraform Var files
MODULE_PATH:=terraform/$(MODULE)
MODULE_VAR_FILE:=values/$(ACCOUNT)/$(RESOURCE_GROUP)/$(LOCATION)/$(MODULE)/$(DEPLOYMENT).tfvars

# Terraform backend configs
TF_BACKEND_RESOURCE_GROUP_NAME=customer-terraform-rg
TF_BACKEND_STORAGE_ACCOUNT_NAME=tfstate
TF_BACKEND_ENVIRONMENT=public
TF_BACKEND_CONTAINER_NAME=terraform-azure-deploy
TF_BACKEND_KEY:=$(ACCOUNT)/$(RESOURCE_GROUP)/$(LOCATION)/$(MODULE)/$(DEPLOYMENT)/terraform.tfstate

TF_PLAN_FILE:=$(ACCOUNT)_$(RESOURCE_GROUP)_$(LOCATION)_$(MODULE)_$(DEPLOYMENT)_$(REV)

install:
	tfenv install

init: clean
	terraform init \
		-backend-config='resource_group_name=$(TF_BACKEND_RESOURCE_GROUP_NAME)' \
		-backend-config='storage_account_name=$(TF_BACKEND_STORAGE_ACCOUNT_NAME)' \
		-backend-config='container_name=$(TF_BACKEND_CONTAINER_NAME)' \
		-backend-config='environment=$(TF_BACKEND_ENVIRONMENT)' \
		-backend-config='key=$(TF_BACKEND_KEY)' $(MODULE_PATH)

upgrade: clean
	terraform init \
		-backend-config='resource_group_name=$(TF_BACKEND_RESOURCE_GROUP_NAME)' \
		-backend-config='storage_account_name=$(TF_BACKEND_STORAGE_ACCOUNT_NAME)' \
		-backend-config='container_name=$(TF_BACKEND_CONTAINER_NAME)' \
		-backend-config='environment=$(TF_BACKEND_ENVIRONMENT)' \
		-backend-config='key=$(TF_BACKEND_KEY)' -upgrade $(MODULE_PATH)

validate:
	terraform validate $(MODULE_PATH)

plan: validate
	terraform plan -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RESOURCE_GROUP)' \
		-var 'location=$(LOCATION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' \
		-out=$(TF_PLAN_FILE).tfplan $(MODULE_PATH)

plan-destroy: validate
	terraform plan -destroy -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RESOURCE_GROUP)' \
		-var 'location=$(LOCATION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' \
		-out=$(TF_PLAN_FILE).tfplan $(MODULE_PATH)

apply: validate
	terraform apply -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RESOURCE_GROUP)' \
		-var 'location=$(LOCATION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' $(MODULE_PATH)

apply-plan:
	terraform apply -state=$(TF_BACKEND_KEY) $(TF_PLAN_FILE).tfplan

destroy: validate
	terraform destroy -state=$(TF_BACKEND_KEY) \
		-var 'resource_group=$(RESOURCE_GROUP)' \
		-var 'location=$(LOCATION)' \
		-var 'customer=$(CUSTOMER)' \
		-var 'env=$(ENV)' \
		-var 'repo=$(REPO)' \
		-var 'deployment=$(DEPLOYMENT)' \
		-var 'module=$(MODULE)' \
		-var-file=$(MODULE_VAR_FILE) \
		-var 'git_commit=$(COMMIT)' $(MODULE_PATH)

output: validate
	terraform output -state=$(TF_BACKEND_KEY) $(OUTPUT)

clean:
	rm -rf .terraform/ || true
	rm *.tfplan  || true