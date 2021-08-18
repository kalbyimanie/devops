terraform {
  required_version = "~> 0.15.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  # backend "gcs" {
  #   bucket = ""
  #   prefix = ""
  # }
}

provider "google" {}
provider "google-beta" {}

module "service-account" {
  source               = "../../../modules/service-account-with-iam-binding"
  project              = "road-to-expert"
  service_account_name = "bastian-host"
  roles                = ["roles/compute.osAdminLogin", "roles/compute.osLogin", "roles/iap.tunnelResourceAccessor"]
}
