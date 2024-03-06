resource "google_container_node_pool" "spot" {
  name           = "spot"
  location       = local.region
  cluster        = google_container_cluster.this.name
  node_locations = [local.region] # Set the desired node locations
  node_count     = 1              # Adjust as needed
  min_count      = 1
  max_count      = 10 # Adjust as needed
  node_version   = local.eks_version
  node_config {
    machine_type = "n1-standard-2" # Adjust as needed
    preemptible  = true
    disk_size_gb = 100 # Adjust as needed
    oauth_scopes = ["https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring"]
  }
  management {
    auto_repair  = true
    auto_upgrade = true
  }
  tags = {
    env = local.env
  }
}
