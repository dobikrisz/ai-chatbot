# Cloud Run Service
resource "google_cloud_run_service" "chatbot" {
  name     = "chatbot-automated"
  location = var.LOCATION

  template {
    spec {
      containers {
        image = "${var.LOCATION}-docker.pkg.dev/${var.PROJECT_ID}/cloud-run-chatbot-deploy/frontend:latest"
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# IAM Policy to Allow Public Access
resource "google_cloud_run_service_iam_member" "public_access" {
  service  = google_cloud_run_service.chatbot.name
  location = google_cloud_run_service.chatbot.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}