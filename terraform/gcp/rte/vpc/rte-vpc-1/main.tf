# source: https://registry.terraform.io/modules/terraform-google-modules/network/google/3.4.0
module "vpc" {
  source       = "terraform-google-modules/network/google"
  version      = "3.4.0"
  project_id   = "road-to-expert"
  network_name = "rte-vpc-1"
  routing_mode = "REGIONAL" # default is GLOBAL

  subnets = [
    # region asia-southeast1
    {
      subnet_name           = "rte-southeast1-app-1"
      subnet_ip             = "10.10.1.0/24"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "application network"
    },
    {
      subnet_name           = "rte-southeast1-app-2"
      subnet_ip             = "10.10.2.0/24"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "application network"
    },
    {
      subnet_name           = "rte-southeast1-db-1"
      subnet_ip             = "10.10.3.0/24"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "database network"
    },
    {
      subnet_name           = "rte-southeast1-db-2"
      subnet_ip             = "10.10.4.0/24"
      subnet_region         = "asia-southeast1"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "database network"
    },
    # end of region asia-southeast1

    # region asia-southeast2
    {
      subnet_name           = "rte-southeast2-app-1"
      subnet_ip             = "10.10.5.0/24"
      subnet_region         = "asia-southeast2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "application network"
    },
    {
      subnet_name           = "rte-southeast2-app-2"
      subnet_ip             = "10.10.6.0/24"
      subnet_region         = "asia-southeast2"
      subnet_private_access = "true"
      subnet_flow_logs      = "false"
      description           = "application network"
    }
    # end of region asia-southeast2
  ]

  routes = [
    {
      name              = "egress-internet"
      description       = "route through IGW to access internet"
      destination_range = "0.0.0.0/0"
      tags              = "egress-internet"
      next_hop_internet = "true"
    }
  ]
}
