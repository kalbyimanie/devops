resource "google_compute_project_metadata_item" "sshkeys" {
  project = var.project_id
  key     = var.key_name
  value   = join("\n", [var.ssh_pub_keys])
}
