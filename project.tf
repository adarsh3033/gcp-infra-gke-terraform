variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

# Cloud Resource Manager API
resource "google_project_service" "cloudresourcemanager" {
  project = var.project_id
  service = "cloudresourcemanager.googleapis.com"
}

# Billing API (optional but useful in automated environments)
# resource "google_project_service" "cloudbilling" {
#   project = var.project_id
#   service = "cloudbilling.googleapis.com"
# }

# Compute Engine API
resource "google_project_service" "compute" {
  project     = var.project_id
  service     = "compute.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}

# IAM API
resource "google_project_service" "iam" {
  project     = var.project_id
  service     = "iam.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}

# Kubernetes Engine (GKE) API
resource "google_project_service" "container" {
  project     = var.project_id
  service     = "container.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}

# Artifact Registry (for container images)
resource "google_project_service" "artifactregistry" {
  project     = var.project_id
  service     = "artifactregistry.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}

# Enable Cloud Logging (optional, for observability)
resource "google_project_service" "logging" {
  project     = var.project_id
  service     = "logging.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}

# Enable Monitoring (optional, for observability)
resource "google_project_service" "monitoring" {
  project     = var.project_id
  service     = "monitoring.googleapis.com"
  depends_on  = [google_project_service.cloudresourcemanager]
}
