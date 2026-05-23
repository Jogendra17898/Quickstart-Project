output "api_public_ip" {
  value = google_compute_address.api_ip.address
}

output "api_endpoint" {
  value = "http://${google_compute_address.api_ip.address}:8000/inference"
}