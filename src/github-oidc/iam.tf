resource "google_iam_workload_identity_pool" "worx_github" {
  provider                  = google-beta
  workload_identity_pool_id = "${var.env_str}-worx-pool-github"
  description               = "Workload Identity Pool for GitHub"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "worx_github" {
  provider                           = google-beta
  workload_identity_pool_provider_id = "${var.env_str}-worx-provider-github"
  workload_identity_pool_id          = google_iam_workload_identity_pool.worx_github.workload_identity_pool_id
  display_name                       = "WORX GitHub Pool Provider"
  description                        = "Workload Identity Pool Provider for GitHub"
  disabled                           = false

  oidc {
    issuer_uri = "https://token.actions.githubusercontent.com"
  }

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.actor"      = "assertion.actor"
    "attribute.repository" = "assertion.repository"
  }
}

resource "google_service_account_iam_binding" "worx_github" {
  service_account_id = google_service_account.worx_github.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    for repo_name in var.github_repo_names : "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.worx_github.name}/attribute.repository/${repo_name}"
  ]
}

resource "google_service_account" "worx_github" {
  account_id   = "${var.env_str}-worx-provisioner"
  display_name = "${var.env_str}-worx-provisioner"
  description  = "Service Account for GitHub Actions"
}