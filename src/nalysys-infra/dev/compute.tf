/* resource "google_compute_instance" "linux_test" {
  name         = "linux-test"
  machine_type = "e2-micro"
  zone         = "asia-northeast1-a"

  boot_disk {
    initialize_params {
      image = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-2004-focal-v20230302"
    }
  }

  tags = ["http-server", "https-server"]

  network_interface {
    network = "default"
    access_config {}
  }

  service_account {
    email = "378171021589-compute@developer.gserviceaccount.com"
    scopes = [
      "https://www.googleapis.com/auth/devstorage.read_only",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring.write",
      "https://www.googleapis.com/auth/service.management.readonly",
      "https://www.googleapis.com/auth/servicecontrol",
      "https://www.googleapis.com/auth/trace.append",
    ]
  }
} */