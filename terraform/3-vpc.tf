resource "google_compute_network" "this" {
  name                    = "main"
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
  project                 = local.project_id


}

resource "google_compute_subnetwork" "this" {
  name          = "main-subnet"
  ip_cidr_range = "10.0.0.0/16"
  network       = google_compute_network.this.self_link
  region        = local.region
}
