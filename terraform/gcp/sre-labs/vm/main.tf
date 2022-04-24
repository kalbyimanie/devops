terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  # backend "gcs" {
  #   bucket = var.bucket
  #   prefix = var.prefix
  # }
  backend "gcs" {}
}

module "compute_engine" {
  source              = "../../modules/compute_engine_with_public_ip"
  number_of_instances = var.number_of_instances
  project_id          = var.project_id
  instance_name       = var.instance_name
  machine_type        = var.machine_type
  extended_disk_size  = var.extended_disk_size
  extended_disk_type  = var.extended_disk_type
  boot_disk_size      = var.boot_disk_size
  boot_disk_type      = var.boot_disk_type
  image_name          = var.image_name
  zone                = var.zone
  network_tags        = var.network_tags
  subnetwork_project  = var.subnetwork_project
  subnetwork_name     = var.subnetwork_name
  path_ssh_pubkey     = var.path_ssh_pubkey
  ssh_user            = var.ssh_user
  network_tier        = var.network_tier
  startup_script      = var.startup_script
  labels              = var.labels
}
