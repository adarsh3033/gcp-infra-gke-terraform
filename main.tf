provider "google" {
  project = var.project_id
  region  = var.region

   impersonate_service_account = var.service_account_email
}

resource "google_project_service" "compute_api" {
  project = var.project_id
  service = "compute.googleapis.com"
}

resource "google_compute_network" "vpc_network" {
  name = "devops-vpc-new-3"
   auto_create_subnetworks = true
}

resource "google_container_cluster" "primary" {
  name     = "devops-cluster-new-3"
  location = var.region

  network                  = google_compute_network.vpc_network.name
  remove_default_node_pool = true
  initial_node_count       = 1

  node_config {
    machine_type  = "e2-medium"
    disk_size_gb  = 20                       
    disk_type     = "pd-standard"           
    oauth_scopes  = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

resource "google_container_node_pool" "primary_nodes" {
  name       = "primary-node-pool-new-3"
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = 2                            

  node_config {
    machine_type  = "e2-medium"
    disk_size_gb  = 20                      
    disk_type     = "pd-standard"           
  }
}
