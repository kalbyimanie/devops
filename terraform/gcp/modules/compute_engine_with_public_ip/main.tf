resource "google_compute_disk" "instance_ext_disk" {
  count   = var.number_of_instances
  name    = format("extended-disk-%s-%d", var.instance_name, count.index + 1)
  type    = var.extended_disk_type
  zone    = var.zone
  size    = var.extended_disk_size
  project = var.project_id
}

resource "google_compute_attached_disk" "default" {
  count    = 1 * var.number_of_instances
  disk     = element(google_compute_disk.instance_ext_disk.*.self_link, count.index)
  instance = element(google_compute_instance.instance.*.self_link, count.index)
  mode     = "READ_WRITE"
  zone     = var.zone
  lifecycle {
    #    prevent_destroy = true
    ignore_changes = []
  }
}

resource "google_compute_instance" "instance" {

  count        = var.number_of_instances
  name         = format("%s-%d", var.instance_name, count.index + 1)
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
      size  = var.boot_disk_size
      type  = var.boot_disk_type
    }
  }

  network_interface {
    # network            = var.network_name
    subnetwork         = var.subnetwork_name
    subnetwork_project = var.subnetwork_project

    # enable ephemeral public ip for the instance
    access_config {
      network_tier = "STANDARD"
    }
  }



  allow_stopping_for_update = true

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(var.path_ssh_pubkey)}"
  }

  lifecycle {
    ignore_changes = [
      attached_disk,
      metadata_startup_script
    ]
  }

  metadata_startup_script = data.template_file.startup_file.rendered
}

data "template_file" "startup_file" {
  template = file(format("%s/${var.startup_script}", path.module))
}
