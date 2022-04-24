data "google_compute_network" "vpc_id" {
  project = var.project_id_of_the_vpc
  name    = var.vpc_id
}

resource "google_compute_subnetwork" "subnetwork" {
  count         = var.number_of_subnetwork
  project       = var.project_id
  name          = format("%s-%d", var.subnetwork_name, count.index + 1)
  region        = var.region_name
  network       = data.google_compute_network.vpc_id.id
  ip_cidr_range = var.primary_ip_cidr_range
  secondary_ip_range {
    range_name    = format("%s-secondary-range-%d", var.subnetwork_name, count.index + 1)
    ip_cidr_range = var.secondary_ip_cidr_range
  }
}
