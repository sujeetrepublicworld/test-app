# -------------------------------
# GKE Cluster
# -------------------------------
resource "google_container_cluster" "gke" {
  name       = "private-gke-cluster"
  location   = "asia-south1"
  network    = google_compute_network.private_vpc.id
  subnetwork = google_compute_subnetwork.private_subnet.id

  # this block allow to private ip 
  ip_allocation_policy {
    cluster_secondary_range_name  = "gke-pods"
    services_secondary_range_name = "gke-services"
  }

  workload_identity_config {
    workload_pool = "dev-test-371111.svc.id.goog"
  }

  resource_labels = {
    environment         = "prod"
    owner               = "devops"
    team                = "platform"
    managed_by          = "terraform"
    cost_center         = "cc-prod-001"
    app                 = "core-services"
    data_classification = "confidential"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = true
  }

  master_authorized_networks_config {
    gcp_public_cidrs_access_enabled = false

    cidr_blocks {
      cidr_block   = "10.10.0.0/24"
      display_name = "Private Subnet Only"
    }
  }

  cluster_autoscaling {
    enabled = true

    resource_limits {
      resource_type = "cpu"
      minimum       = 1
      maximum       = 50
    }

    resource_limits {
      resource_type = "memory"
      minimum       = 1
      maximum       = 200
    }
  }

  logging_service    = "logging.googleapis.com/kubernetes"
  monitoring_service = "monitoring.googleapis.com/kubernetes"

  network_policy {
    enabled  = true
    provider = "CALICO"
  }

  node_pool {
    name       = "default-node-pool"
    node_count = 3

    node_config {
      machine_type = "e2-medium"
      oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]

      labels = {
        environment = "prod"
        managed_by  = "terraform"
        team        = "platform"
      }

      shielded_instance_config {
        enable_secure_boot          = true
        enable_integrity_monitoring = true
      }

      workload_metadata_config {
        mode = "GKE_METADATA"
      }
    }

    autoscaling {
      min_node_count = 1
      max_node_count = 5
    }
  }
}

# Replace this with your laptop's public IP
variable "my_laptop_ip" {
  sensitive = true
  #default = "115.241.92.250/32"
  default = "157.49.6.131/32"
}
