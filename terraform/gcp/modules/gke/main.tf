variable "project" {
  default = "REPLACE_ME"
}
variable "region" {
  default = "REPLACE_ME"
}
variable "zone" {
  default = "REPLACE_ME"
}
variable "machine_type" {
  default = "REPLACE_ME"
}
provider "google" {
  project     = var.project
  region      = var.region
  zone        = var.zone
  credentials = file("REPLACE_ME_WITH_YOUR_CREDENTIAL.json")
}
resource "google_service_account" "cluster-serviceaccount" {
  account_id   = "cluster-serviceaccount"
  display_name = "Service Account For Terraform To Make GKE Cluster"
}
variable "cluster_version" {
  default = "1.16"
}
resource "google_container_cluster" "cluster" {
  name               = "tutorial"
  location           = var.zone
  min_master_version = var.cluster_version
  project            = var.project
  lifecycle {
    ignore_changes = [
      # Ignore changes to min-master-version as that gets changed
      # after deployment to minimum precise version Google has
      min_master_version
    ]
  }
  # We can't create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
  workload_identity_config {
    identity_namespace = "${var.project}.svc.id.goog"
  }
}
resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "tutorial-cluster-node-pool"
  location   = var.zone
  project    = var.project
  cluster    = google_container_cluster.cluster.name
  node_count = 1
  autoscaling {
    min_node_count = 1
    max_node_count = 5
  }

  version = var.cluster_version
  node_config {
    preemptible  = true
    machine_type = var.machine_type
    # Google recommends custom service accounts that have cloud-platform scope
    # and permissions granted via IAM Roles.
    service_account = google_service_account.cluster-serviceaccount.email
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
    metadata = {
      disable-legacy-endpoints = "true"
    }
  }
  lifecycle {
    ignore_changes = [
      # Ignore changes to node_count, initial_node_count and version
      # otherwise node pool will be recreated if there is drift between what
      # terraform expects and what it sees
      initial_node_count,
      node_count,
      version
    ]
  }
}

# create service account for workload-identity
resource "google_service_account" "workload-identity-user-sa" {
  account_id   = "workload-identity-tutorial"
  display_name = "Service Account For Workload Identity"
}
resource "google_project_iam_member" "storage-role" {
  role = "roles/storage.admin"
  # role   = "roles/storage.objectAdmin"
  member = "serviceAccount:${google_service_account.workload-identity-user-sa.email}"
}
resource "google_project_iam_member" "workload_identity-role" {
  role   = "roles/iam.workloadIdentityUser"
  member = "serviceAccount:${var.project}.svc.id.goog[workload-identity-test/workload-identity-user]"
}
