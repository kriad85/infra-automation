variable "ibmcloud_api_key" {}

variable "cluster_name" {}

variable "vpc_id" {}

variable "subnet_id" {}

provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
  generation         = 2
  region             = "eu-de"
}

data "ibm_resource_group" "resource_group" {
  name = "Default"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = var.cluster_name
  vpc_id            = var.vpc_id
  flavor            = "mx2.2x16"
  worker_count      = 1
  resource_group_id = data.ibm_resource_group.resource_group.id
  kube_version      = "1.17.9"

  zones {
    subnet_id = var.subnet_id
    name      = "eu-de-1"
  }
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = "${ibm_container_vpc_cluster.cluster.id}"
}
