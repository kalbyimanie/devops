terraform {
  required_version = "~> 0.13.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
}

provider "google" {}

module "gcs" {
  source        = "../../modules/gcs"

  project_name  = "road-to-expert"
  region_name   = "asia-southeast1"
  location_name = "asia-southeast1"
  bucket_name   = "gcs-rte-dev"
  versioning    = true
}