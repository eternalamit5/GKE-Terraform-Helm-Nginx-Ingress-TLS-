resource "google_compute_subnetwork" "subnet1" {
  name          = "subnet1"
  ip_cidr_range = "10.0.0.0/19"
  region        = local.region
  network       = google_compute_network.this.self_link # Reference to the main network created in vpc.tf
}

resource "google_compute_subnetwork" "subnet2" {
  name          = "subnet2"
  ip_cidr_range = "10.0.32.0/19"
  region        = local.region
  network       = google_compute_network.this.self_link # Reference to the main network created in vpc.tf
}
