provider "google" {
  project     = var.project_id
  credentials = var.GCP_SA_KEY
  region      = var.region
}