variable "project_name" {
  type  = string
}

variable "bucket_name" {
  type  = string 
}

variable "location_name" {
  type  = string 
}

variable "region_name" {
  type  = string 
}

variable "versioning" {
  type  = bool 
}

provider "google" {
  project = var.project_name
  region  = var.region_name  
}

resource "google_storage_bucket" "gcs-rte-dev" {
  name          = var.bucket_name
  location      = var.location_name
  force_destroy = true
  project       = var.project_name

  versioning {
    enabled     = var.versioning
  }
}