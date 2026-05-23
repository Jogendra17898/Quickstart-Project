resource "google_compute_firewall" "rpc" {

  name    = "rpc-firewall"
  network = google_compute_network.vpc.name

  allow {
    protocol = "tcp"
    ports = ["22"]
  }

  allow {
    protocol = "tcp"
    ports = ["8000"]
  }

  allow {
    protocol = "tcp"
    ports = ["5001"]
  }

  allow {
    protocol = "tcp"
    ports = ["5002"]
  }

  allow {
    protocol = "tcp"
    ports = ["6000"]
  }

  source_ranges = [
    "0.0.0.0/0"
  ]
}