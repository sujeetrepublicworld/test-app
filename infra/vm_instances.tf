# -------------------------------
# Bastion VM with public IP
# -------------------------------
resource "google_compute_instance" "bastion" {
  name         = "bastion-vm"
  machine_type = "e2-medium"
  zone         = "asia-south1-a"

  tags = ["bastion-public"] # For firewall rule

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }
  
  service_account {
  email  = "bastion-sa@dev-test-371111.iam.gserviceaccount.com"
  scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }

  network_interface {
    network    = google_compute_network.private_vpc.id
    subnetwork = google_compute_subnetwork.private_subnet.id

    # Assign ephemeral public IP
    access_config {}
  }

  metadata_startup_script = <<-EOT
    # Install kubectl and gcloud
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
    curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
    echo "deb https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt-get update && sudo apt-get install -y google-cloud-sdk kubectl
  EOT
}
