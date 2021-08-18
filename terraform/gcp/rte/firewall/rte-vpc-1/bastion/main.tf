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
  source        = "../../../../modules/firewall-with-network-tag"
  firewall_name = "bastion"
  network_name  = "rte-vpc-1"
  project_name  = "road-to-expert"
  protocol      = "tcp"
  list_ports    = ["22"]

  network_tags = [
    "bastion"
  ]

  source_ranges = [
    "35.247.142.161/32"
  ]
}
