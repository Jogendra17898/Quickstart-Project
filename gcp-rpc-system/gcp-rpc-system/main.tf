resource "google_compute_network" "vpc" {
  name                    = "rpc-vpc"
  auto_create_subnetworks = false
}