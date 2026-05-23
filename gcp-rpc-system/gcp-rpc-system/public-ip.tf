resource "google_compute_address" "api_ip" {
  name   = "api-public-ip"
  region = var.region
}