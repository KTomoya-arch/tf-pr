resource "google_secret_manager_secret" "worx_be" {
  for_each  = local.secret_keys_be
  project   = local.host_project
  secret_id = each.value

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "worx_bff_engine" {
  for_each  = local.secret_keys_bff_engine
  project   = local.service_projects["engine"]
  secret_id = each.value

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "worx_bff_personal" {
  for_each  = local.secret_keys_bff_personal
  project   = local.service_projects["personal"]
  secret_id = each.value

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "worx_bff_labor" {
  for_each  = local.secret_keys_bff_labor
  project   = local.service_projects["labor"]
  secret_id = each.value

  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret" "worx_bff_mynumber" {
  for_each  = local.secret_keys_bff_mynumber
  project   = local.service_projects["mynumber"]
  secret_id = each.value

  replication {
    automatic = true
  }
}