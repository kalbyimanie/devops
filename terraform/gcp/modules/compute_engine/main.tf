# data "template_file" "startup_file" {
#   template = file("../../../modules/compute_engine/scripts/startup.sh")


# }

resource "google_compute_instance" "instance" {
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  name         = var.instance_name
  project      = var.project_id
  machine_type = var.machine_type
  zone         = var.zone

  tags   = var.network_tags
  labels = var.labels

  boot_disk {
    auto_delete = true
    mode        = "READ_WRITE"
    initialize_params {
      image = "ubuntu-1804-bionic-v20210817"
    }
  }

  network_interface {
    network            = var.network_name
    subnetwork         = var.subnetwork_name
    subnetwork_project = var.project_id

    access_config {
      network_tier = var.network_tier
    }
  }
  metadata_startup_script = file("../../../modules/compute_engine/scripts/startup.sh")

}
