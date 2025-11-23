# Jenkins

variable "jenkins_storage_account" {
  type = string
}

variable "jenkins_master_ad_application_name" {
  type = string
}

variable "jenkins_master_admin_email" {
  type = list(any)
}

variable "jenkins_git_username" {
  type = string
}

## Jenkins Master - Jira Site

variable "jira_site_url" {
  type = string
}

variable "jira_site_client_id" {
  type = string
}

variable "jira_site_credential_keyvault_id" {
  type = string
}

## Jenkins Master - Service Config

variable "app_gateway_name" {
  type = string
}

variable "app_gateway_backend_pool_name" {
  type = string
}

variable "jenkins_master_service_port" {
  type = number
}

variable "jenkins_master_health_check_protocol" {
  type = string
}

variable "jenkins_master_health_check_path" {
  type = string
}

variable "jenkins_master_health_check_response_code" {
  type = string
}

## Jenkins Master - Docker configs

variable "jenkins_master_service_tag" {
  type = string
}

## Jenkins Master - Scaling Config

variable "jenkins_master_vm_type" {
  type = string
}

variable "jenkins_master_max_instances" {
  type = number
}

variable "jenkins_master_min_instances" {
  type = number
}

variable "jenkins_master_scale_in_policy" {
  type = string
}

variable "jenkins_master_scale_overprovision" {
  type = bool
}

variable "jenkins_master_priority" {
  type = string
}

## Jenkins Worker config

variable "jenkins_worker_vm_image_name" {
  type = string
}

variable "jenkins_worker_max" {
  type = string
}

## Jenkins Worker config - Default

variable "jenkins_worker_default_location" {
  type = string
}

variable "jenkins_worker_default_vm_size" {
  type = string
}

variable "jenkins_worker_default_vm_disk_size" {
  type = string
}

## Jenkins Worker config - Medium

variable "jenkins_worker_medium_location" {
  type = string
}

variable "jenkins_worker_medium_vm_size" {
  type = string
}

variable "jenkins_worker_medium_vm_disk_size" {
  type = string
}

## Jenkins Worker config - Large

variable "jenkins_worker_large_location" {
  type = string
}

variable "jenkins_worker_large_vm_size" {
  type = string
}

variable "jenkins_worker_large_vm_disk_size" {
  type = string
}