data "rancher2_cloud_credential" "aks_credentials" {
  name = var.credential_name
}

resource "rancher2_cluster" "aks_cluster" {
  name        = var.cluster_name
  description = "Imported AKS cluster using Terraform"
  aks_config_v2 {
    cloud_credential_id = data.rancher2_cloud_credential.aks_credentials.id
    resource_group      = var.resource_group
    resource_location   = var.location
    imported            = true
  }
}