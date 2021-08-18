resource "google_compute_instance" "instance" {
  service_account {
    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    email  = var.service_account_email
    scopes = ["cloud-platform"]
  }

  name         = var.instance_name
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
    network    = var.network_name
    subnetwork = var.subnetwork_name

    access_config {
      network_tier = var.network_tier
    }
  }

  # metadata = {
  #   sshKeys = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDAm2D85KdBOcDGMcxkGB7g1fQuQO4koTHXnQhKeh61ms8qugXV0vxsJ/dHSMgjYdFHbK85F0soVvc7btO7mevr/GFfAde3c5+Zbm03goZYYN4MqPPrO9KTtyaS704MFdNGgkq9G/IX6U04llNBVeNUPAirfJaJ7WtweVOaaDijL0dXnaunD6Zja9O38l5dkuRZ1KBgB0AzMk7mkk5baifkyU45RTTTbCiZXgwJJNgiVHBeuIYK1ZAJV49sGKXyfyhQLmhloLH5Xi9v5i+h3c0mQuHEBiy656BzuoL7wXo8Lf9Ee0FG7KXZ++HrK4tDh8Qa33b/d7ZWb9VuCi2LYhLJNPHXccSD7zMbBT2fj6603ndTahm2asEJ/yWQnv5lyNQyBdXoOh0HcrmHLYLJ41SU/gwRz2rQawMSGo7nV5Fq31A1/7z9DAZIe1I/tNXBeQ2LM/meIObSq9cUBa0uQXclJNRU5Hmq9rcGWqAFVLOT67SqAlYonmwq4eo7XAoRlvE= kalbyimanie@Kalby-Imanie.local"
  # }

  metadata_startup_script = "scripts/startup.sh"

}
