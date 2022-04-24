terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  backend "gcs" {}
}

module "vpc_network" {
  source = "../../modules/vpc_subnet"
  # vpc config—vpc requires to be created initially
  project_id_of_the_vpc = var.project_id_of_the_vpc
  vpc_id                = var.vpc_id

  # subnetwork config
  number_of_subnetwork    = var.number_of_subnetwork
  subnetwork_name         = var.subnetwork_name
  project_id              = var.project_id
  region_name             = var.region_name
  primary_ip_cidr_range   = var.primary_ip_cidr_range
  secondary_ip_cidr_range = var.secondary_ip_cidr_range
}
