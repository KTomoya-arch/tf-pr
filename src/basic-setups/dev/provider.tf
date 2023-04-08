provider "google" {
  project = local.host_project
  region  = local.region
}

provider "google-beta" {
  project = local.host_project
  region  = local.region
}