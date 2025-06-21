variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "service_account_email" {
  description = "Email of the service account"
  type        = string
}
