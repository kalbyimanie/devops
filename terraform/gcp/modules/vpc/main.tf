resource "google_compute_network" "vpc_network" {
  description                     = "VPC network resouce"
  project                         = var.project_id
  name                            = var.vpc_network_name
  auto_create_subnetworks         = var.auto_create_subnetworks
  mtu                             = var.mtu
  routing_mode                    = var.routing_mode
  delete_default_routes_on_create = var.delete_default_routes_on_create
}
