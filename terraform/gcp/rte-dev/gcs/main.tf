terraform {
  required_version = ">= 0.14.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  backend "gcs" {
    bucket = "rte-dev-common"
    prefix = "state/bucket/"
  }
}

provider "google" {}

module "gcs" {
  source        = "../../modules/gcs"

  project_name  = "road-to-expert"
  region_name   = "asia-southeast1"
  location_name = "asia-southeast1"
  bucket_name   = "rte-dev-common"
  versioning    = true
}