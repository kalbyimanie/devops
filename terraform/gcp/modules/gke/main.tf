resource "google_container_cluster" "dev_common" {
  provider                  = google
  project                   = var.project_id
  name                      = var.cluster_name
  initial_node_count        = var.node_count
  node_locations            = var.node_locations
  location                  = var.location
  monitoring_service        = "none"
  remove_default_node_pool  = true
  default_max_pods_per_node = 10
  network                   = var.network
  subnetwork                = var.subnetwork
  ip_allocation_policy {
    cluster_ipv4_cidr_block = ""
  }
  network_policy {
    provider = "CALICO"
    enabled  = true
  }
  addons_config {
    network_policy_config {
      disabled = false
    }
  }

  cluster_autoscaling {
    enabled = true
    resource_limits {
      resource_type = "cpu"
      maximum       = var.max_cpu
    }
    resource_limits {
      resource_type = "memory"
      maximum       = var.max_memory
    }
  }
}

resource "google_container_node_pool" "app1" {
  provider   = google
  project    = var.project_id
  name       = var.node_pool_name
  cluster    = google_container_cluster.dev_common.name
  node_count = var.node_count
  location   = var.location
  autoscaling {
    min_node_count = 1
    max_node_count = var.node_count
  }

  node_config {
    # taint = [
    #   {
    #     effect = "NO_SCHEDULE"
    #     key    = "node_pool_name"
    #     value  = var.node_pool_name
    #   }
    # ]
    preemptible  = true
    machine_type = var.machine_type # e2-standard-2 » Rp.290.00/hour

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = var.service_account
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}
