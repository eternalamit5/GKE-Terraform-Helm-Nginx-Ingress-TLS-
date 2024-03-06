resource "google_project" "this" {
  name       = local.resource_group_name
  project_id = local.project_id

}
