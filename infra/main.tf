variable "ibmcloud_api_key" {}

provider "ibm" {
  ibmcloud_api_key   = var.ibmcloud_api_key
  generation         = 2
  region             = "eu-de"
}

resource "ibm_is_vpc" "vpc1" {
  name = "myvpc2"
}

resource "ibm_is_subnet" "subnet1" {
  name                     = "mysubnet1"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = "eu-de-1"
  total_ipv4_address_count = 256
}

resource "ibm_is_subnet" "subnet2" {
  name                     = "mysubnet2"
  vpc                      = ibm_is_vpc.vpc1.id
  zone                     = "eu-de-2"
  total_ipv4_address_count = 256
}

data "ibm_resource_group" "resource_group" {
  name = "Default"
}

resource "ibm_container_vpc_cluster" "cluster" {
  name              = "mycluster"
  vpc_id            = ibm_is_vpc.vpc1.id
  flavor            = "mx2.2x16"
  worker_count      = 1
  resource_group_id = data.ibm_resource_group.resource_group.id
  kube_version      = "1.17.7"

  zones {
    subnet_id = ibm_is_subnet.subnet1.id
    name      = "eu-de-1"
  }
}

data "ibm_container_cluster_config" "cluster_config" {
  cluster_name_id = "${ibm_container_vpc_cluster.cluster.id}"
}
