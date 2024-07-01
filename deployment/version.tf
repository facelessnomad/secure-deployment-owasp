terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.33.0"
    }
  }
  backend "gcs" {
    bucket      = "secure-deployment-owasp"
    prefix      = "terraform/state"
    credentials = ""
  }
}