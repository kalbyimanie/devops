resource "google_service_account" "service_account" {
  project    = var.project
  account_id = var.service_account_name
}

locals {
  all_service_account_roles = concat(var.roles)
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.all_service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}

resource "google_service_account_iam_binding" "service_account_iam_binding" {
  service_account_id = google_service_account.service_account.name
  role               = "roles/iam.serviceAccountUser"
  members = [
    "serviceAccount:${google_service_account.service_account.email}"
  ]
}
