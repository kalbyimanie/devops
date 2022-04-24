terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  backend "gcs" {}
}

module "vpc_network" {
  source                          = "../../../modules/vpc"
  project_id                      = var.project_id
  vpc_network_name                = var.vpc_network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  mtu                             = var.mtu
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}
