resource "google_storage_bucket" "this" {
  name          = "devtest-${random_integer.this.result}"
  location      = local.region
  storage_class = "STANDARD"
  force_destroy = true # Note: This will allow Terraform to delete the bucket even if it's not empty
}

resource "google_project_iam_member" "dev_test" {
  project = local.project_id
  role    = "roles/storage.admin"
  member  = "serviceAccount:${google_container_cluster.this.service_account_email}"
}
