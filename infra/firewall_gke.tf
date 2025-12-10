#port open for kubernetes matric 
resource "google_compute_firewall" "allow-metrics-server-kubelet" {
  name    = "allow-metrics-server-kubelet"
  network = google_compute_network.private_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["10250"]
  }

  # Source: metrics-server pod IPs (cluster internal CIDR)
  source_ranges = ["10.10.0.0/24"]
  direction     = "INGRESS"
}

# -------------------------------
# Firewall: allow internal communication
# -------------------------------
resource "google_compute_firewall" "allow-internal" {
  name    = "allow-internal-vpc"
  network = google_compute_network.private_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["10.10.0.0/24"] # Only internal subnet
  direction     = "INGRESS"
}

# -------------------------------
# Firewall: allow cluster nodes to master communication
# -------------------------------
resource "google_compute_firewall" "allow-master-node" {
  name    = "allow-master-node"
  network = google_compute_network.private_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["443"] # Kubernetes API server
  }

  source_ranges = ["10.10.0.0/24"] # Node subnet
  direction     = "INGRESS"
}

# -------------------------------
# Firewall: allow Bastion SSH (only from laptop)
# -------------------------------
resource "google_compute_firewall" "allow-bastion-ssh-laptop" {
  name    = "allow-bastion-ssh-laptop"
  network = google_compute_network.private_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["22", "8080",]
  }

  source_ranges = [var.my_laptop_ip] # Only your laptop
  target_tags   = ["bastion-public"]
  direction     = "INGRESS"
}

# 7️⃣ Firewall rule to allow LB traffic to private nodes
resource "google_compute_firewall" "allow_lb_to_nodes" {
  name    = "allow-lb-to-nodes"
  network = google_compute_network.private_vpc.id

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  # External LB IP ranges (health check + traffic)
  source_ranges = ["130.211.0.0/22", "35.191.0.0/16"]
  direction     = "INGRESS"
}

