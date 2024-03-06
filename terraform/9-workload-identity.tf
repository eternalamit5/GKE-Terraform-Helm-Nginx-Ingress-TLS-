resource "google_service_account" "dev_test" {
  account_id   = "dev-test"
  display_name = "Dev Test Service Account"
}

resource "google_project_iam_member" "dev_test" {
  project = local.project_id
  role    = "roles/iam.workloadIdentityUser"
  member  = "serviceAccount:${local.project_id}.svc.id.goog[dev/my-account]"
}

resource "google_service_account_iam_member" "dev_test" {
  service_account_id = google_service_account.dev_test.id
  role               = "roles/iam.workloadIdentityUser"
  member             = "serviceAccount:${local.project_id}.svc.id.goog[dev/my-account]"
}
