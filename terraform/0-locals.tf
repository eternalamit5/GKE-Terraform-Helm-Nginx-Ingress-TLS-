locals {
  env                 = "dev"
  region              = "us-east1"        # Replace with the desired GCP region
  project_id          = "your-project-id" # Replace with your GCP project ID
  resource_group_name = "tutorial"        # Resource group is not a concept in GCP, but you can keep it for organizational purposes
  gke_name            = "demo"            # Renamed from eks_name to match GCP's terminology
  gke_version         = "1.27"            # Renamed from eks_version to match GCP's terminology
}
