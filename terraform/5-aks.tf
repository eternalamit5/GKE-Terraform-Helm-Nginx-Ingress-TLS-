resource "google_container_cluster" "this" {
  name               = "${local.env}-${local.eks_name}"
  location           = local.region
  project            = local.project_id
  initial_node_count = 1 # Adjust as needed

  master_auth {
    username = "your username"
    password = "your password"

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  node_pool {
    name               = "default-pool"
    machine_type       = "n1-standard-2" # Adjust as needed
    initial_node_count = 1               # Adjust as needed
    autoscaling {
      min_node_count = 1
      max_node_count = 10 # Adjust as needed
    }
    management {
      auto_repair  = true
      auto_upgrade = true
    }
    node_config {
      oauth_scopes = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
      ]
    }
  }

  network_config {
    network = google_compute_network.this.name # Assuming the network is defined in vpc.tf
  }

  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
    kubernetes_dashboard {
      disabled = false
    }
  }

  node_config {
    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }

  depends_on = [
    google_compute_network.this,
    google_compute_subnetwork.subnet1, # Assuming the subnets are defined in subnets.tf
    google_compute_subnetwork.subnet2
  ]
}
