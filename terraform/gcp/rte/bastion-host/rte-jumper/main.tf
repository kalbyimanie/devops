module "bastion" {
  source                = "../../../modules/compute_engine"
  instance_name         = "bastion"
  machine_type          = "custom-2-{2*1028}"
  zone                  = "asia-southeast1-a"
  network_tags          = ["bastion"]
  service_account_email = "bastian-host@road-to-expert.iam.gserviceaccount.com"
  network_name          = "rte-vpc-1"
  subnetwork_name       = "rte-southeast1-app-1"
  network_tier          = "STANDARD"
  labels = {
    service_type = "bastion"
  }
}
