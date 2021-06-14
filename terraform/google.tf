provider "google" {
  project = var.gce_project_id
  region  = var.gce_region
  zone    = var.gce_zone
}

resource "google_compute_instance" "vm_instance" {
  name         = format("web-%02d", count.index + 1)
  machine_type = "f1-micro"
  count        = var.google_web_count
  boot_disk {
    initialize_params {
      image = var.gce_image_name
    }
  }
  metadata = {
    ssh-keys = "${var.gce_ssh_user}:${var.ssh_key_pub}"
  }
  metadata_startup_script = file("scripts/firstboot.sh")
  network_interface {
    network = google_compute_network.vpc_network.self_link
    access_config {
    }
  }
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "default" {
  name    = "terraform-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "1000-2000"]
  }
}
