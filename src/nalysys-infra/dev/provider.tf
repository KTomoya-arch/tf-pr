provider "google" {
  project = local.host_project
  region  = local.regions["tokyo"]
}

provider "google-beta" {
  project = local.host_project
  region  = local.regions["tokyo"]
}