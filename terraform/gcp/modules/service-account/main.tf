resource "google_service_account" "service_account" {
  project    = var.project
  account_id = var.account_name
}

locals {
  service_account_roles = concat(var.roles)
}

resource "google_project_iam_member" "service_account-roles" {
  for_each = toset(local.service_account_roles)

  project = var.project
  role    = each.value
  member  = "serviceAccount:${google_service_account.service_account.email}"
}
