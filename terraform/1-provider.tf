provider "google" {
  project = local.project_id
  region  = local.region
  zone    = "your-preferred-zone" # Specify the zone where you want to deploy resources
  # You might need to add more configurations depending on your requirements, e.g., credentials
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.75.0" # Use the latest version compatible with your configuration
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.1.0"
    }
  }
}

