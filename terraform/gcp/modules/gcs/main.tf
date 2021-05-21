provider "google" {
  project = var.project_name
  region  = var.region_name
}

resource "google_storage_bucket" "bucket" {
  name          = var.bucket_name
  location      = var.location_name
  force_destroy = true
  project       = var.project_name

  versioning {
    enabled = var.versioning
  }
}
