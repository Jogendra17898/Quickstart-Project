#API VM

resource "google_compute_instance" "api_vm" {

  name         = "api-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {

    subnetwork = google_compute_subnetwork.public.id

    network_ip = "10.0.1.10"

    access_config {
      nat_ip = google_compute_address.api_ip.address
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = file("${path.module}/cloud-init/api.sh")

  tags = ["rpc"]
}

#Engine VM

resource "google_compute_instance" "engine_vm" {

  name         = "engine-vm"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {

    subnetwork = google_compute_subnetwork.private.id

    network_ip = "10.0.2.10"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = file("${path.module}/cloud-init/engine.sh")

  tags = ["rpc"]
}

#Python Worker VM

resource "google_compute_instance" "python_vm" {

  name         = "python-worker"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {

    subnetwork = google_compute_subnetwork.private.id

    network_ip = "10.0.2.11"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = file("${path.module}/cloud-init/python-worker.sh")

  tags = ["rpc"]
}

#TS Worker VM

resource "google_compute_instance" "ts_vm" {

  name         = "ts-worker"
  machine_type = "e2-micro"
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2404-lts-amd64"
    }
  }

  network_interface {

    subnetwork = google_compute_subnetwork.private.id

    network_ip = "10.0.2.12"
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_public_key_path)}"
  }

  metadata_startup_script = file("${path.module}/cloud-init/ts-worker.sh")

  tags = ["rpc"]
}