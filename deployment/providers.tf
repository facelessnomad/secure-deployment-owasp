provider "google" {
  project = var.project_id
  #   credentials = var.GCP_SA_KEY
  credentials = file("./key.json")
  region      = var.region
}