resource "google_storage_bucket" "worx_be_cloud_functions" {
  project                     = local.host_project
  name                        = "worx-${local.env_str}-cloud-functions"
  storage_class               = "STANDARD"
  location                    = "ASIA"
  requester_pays              = false
  default_event_based_hold    = false
  uniform_bucket_level_access = true

  autoclass {
    enabled = true
  }
}