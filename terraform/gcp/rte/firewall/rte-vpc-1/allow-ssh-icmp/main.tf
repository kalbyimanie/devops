terraform {
  required_version = "~> 0.15.0"
  required_providers {
    google = "~> 3.10"
  }
  # backend "gcs" {
  #   bucket = ""
  #   prefix = ""
  # }
}

module "firewall" {
  source       = "../../../../modules/firewall"
  network_name = "rte-vpc-1"
  project_name = "road-to-expert"
}
