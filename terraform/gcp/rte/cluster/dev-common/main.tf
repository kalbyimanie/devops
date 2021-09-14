module "cluster_dev_common" {
  source          = "../../../modules/gke"
  project_id      = "road-to-expert"
  location        = "asia-southeast2-a"
  cluster_name    = "cluster-dev-common"
  node_pool_name  = "app1"
  node_count      = 2
  machine_type    = "e2-standard-2"
  service_account = "cluster-dev-common@road-to-expert.iam.gserviceaccount.com"
  network         = "rte-vpc-1"
  subnetwork      = "rte-southeast2-cluster-1"
  node_locations  = ["asia-southeast2-b"]
  max_memory      = "16"
  max_cpu         = "4"
}
