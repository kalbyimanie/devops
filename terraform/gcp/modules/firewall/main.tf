resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh-icmp"
  network = var.network_name
  project = var.project_name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports = [
      "22"
    ]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}
