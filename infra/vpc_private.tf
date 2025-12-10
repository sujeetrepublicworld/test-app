# =====================================
# VPC & Subnet with Secondary Ranges
# =====================================
resource "google_compute_network" "private_vpc" {
  name                    = "private-vpc-test"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name                     = "private-subnet-test"
  region                   = "asia-south1"
  network                  = google_compute_network.private_vpc.id
  ip_cidr_range            = "10.10.0.0/24"
  private_ip_google_access = true

  # Secondary ranges required for GKE
  secondary_ip_range {
    range_name    = "gke-pods"
    ip_cidr_range = "10.20.0.0/16"
  }

  secondary_ip_range {
    range_name    = "gke-services"
    ip_cidr_range = "10.30.0.0/20"
  }
}

# =====================================
# Cloud NAT
# =====================================
resource "google_compute_router" "nat-router" {
  name    = "private-nat-router"
  network = google_compute_network.private_vpc.name
  region  = "asia-south1"
}

resource "google_compute_router_nat" "nat-config" {
  name                              = "private-nat-config"
  router                            = google_compute_router.nat-router.name
  region                            = google_compute_router.nat-router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
