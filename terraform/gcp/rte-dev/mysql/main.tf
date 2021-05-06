terraform {
  required_version = "~> 0.14.0"
  required_providers {
    google      = "~> 3.10"
    google-beta = "~> 3.10"
  }
  backend "gcs" {
    bucket = ""
    prefix = "path/to/gcs/"
  }
}