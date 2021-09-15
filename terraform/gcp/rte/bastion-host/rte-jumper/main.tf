module "bastion" {
  source        = "../../../modules/compute_engine"
  project_id    = "road-to-expert"
  instance_name = "bastion"
  # machine_type          = "custom-2-{8*1028}"
  machine_type          = "e2-standard-2"
  zone                  = "asia-southeast1-a"
  network_tags          = ["bastion"]
  service_account_email = "bastian-host@road-to-expert.iam.gserviceaccount.com"
  network_name          = "rte-vpc-1"
  subnetwork_name       = "rte-southeast1-app-1"
  subnetwork_project    = "road-to-expert"
  network_tier          = "STANDARD"
  path_ssh_pubkey       = "/Users/kalbyimanie/.ssh/developer.pub"
  ssh_user              = "kalbyimanie"
  labels = {
    service_type = "bastion"
  }
}
