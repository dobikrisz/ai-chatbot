# Cloud Run Service
resource "google_cloud_run_v2_service" "chatbot" {
  name     = "chatbot-automated"
  location = var.LOCATION

  template {
    containers {
      image = "${var.LOCATION}-docker.pkg.dev/${var.PROJECT_ID}/cloud-run-chatbot-deploy/frontend:test"
    }
    scaling {
      max_instance_count = 1
    }
  }
}

# IAM Policy to Allow Public Access
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_v2_service.chatbot.name
  location = google_cloud_run_v2_service.chatbot.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}