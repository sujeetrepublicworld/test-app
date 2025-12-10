# -------------------------------
# Provider
# -------------------------------

terraform {
  backend "gcs" {
    bucket  = "gke-terraform-test-bucket"
    prefix  = "terraform/state"
  }
}


provider "google" {
  project = "dev-test-371111"
  region  = "asia-south1"
}
