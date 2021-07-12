terraform {
  required_version = "~> 0.13"
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
  source       = "../../../modules/service-account"
  project      = "road-to-expert"
  account_name = "custom-service-account"
  roles        = ["roles/storage.admin", "roles/iam.workloadIdentityUser"]
}
