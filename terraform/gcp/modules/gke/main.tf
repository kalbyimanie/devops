resource "google_service_account" "cluster-dev-common-service-account" {
  account_id   = "cluster-dev-common"
  display_name = "cluster-dev-common-service-account"
}

resource "google_container_cluster" "dev-common" {
  name                     = var.cluster_name
  initial_node_count       = 1
  remove_default_node_pool = true

}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name = ""
}
