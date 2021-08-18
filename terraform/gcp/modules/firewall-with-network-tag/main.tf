resource "google_compute_firewall" "firewall" {
  name    = var.firewall_name
  network = var.network_name
  project = var.project_name

  dynamic "allow" {
    iterator = ports
    for_each = var.list_ports
    content {
      protocol = var.protocol
      ports    = [ports.value]
    }
  }

  source_ranges = var.source_ranges

  target_tags = var.network_tags
}
